# 注意如果开启 pry-stack_explorer, 就不要使用 debugger, 因为进入新的上下文后, pry-stack_explorer 将失效.

require 'binding_of_caller'

class Binding
  def _pry(host=nil, port=nil, options={})
    if host
      require 'pry-remote'
    else
      require 'pry'
    end
    require 'pryx/ap_hack'
    require 'pryx/break_hack'
    # 这个必须在最后才有效, 但是目前存在一个问题，就是会将 pry3, pry! 加入 stacks
    require 'pry-stack_explorer'

    Pry::Commands.block_command 'cc', 'Continue, but stop in pry! breakpoint' do
      Pry.instance_variable_set(:@initial_session, true)
      ENV['Pry_was_started'] = nil
      throw(:breakout)
    end

    if host
      notify_send('loading remote pry ...')
      # remote_pry(host, port, options) if Pry.initial_session?
      remote_pry(host, port, options)
    else
      warn '[1m[33mloading pry ...[0m'
      self.pry
    end
  end

  def _irb(_host=nil)
    warn '[1m[33mloading irb ...[0m'

    self.irb
  end
end

module Kernel
  # 运行 pry! 会被拦截, 且只会被拦截一次.
  def pry!(caller=2, remote: nil, port: 9876)
    return unless ENV['Pry_was_started'].nil?

    ENV['Pry_was_started'] = 'true'

    if background?
      remote = '0.0.0.0'
      port = 9876
    end

    pry3(caller, remote: remote, port: port)

    # 这里如果有代码, 将会让 pry! 进入这个方法, 因此保持为空.
  end

  # 注意：pryr 总是会被拦截。
  def pryr
    pry3(caller=2, remote: '0.0.0.0', port: 9876)
  end

  # 在 pry! 之前如果输入这个，会让下次执行的 pry! 被拦截一次， 而不管之前是否有执行过 pry!
  def repry!
    ENV['Pry_was_started'] = nil
  end

  # 和 pry! 的差别就是，pry? 使用 pry-state 插件输出当前 context 的很多变量内容。
  # 注意：不需要总是开启 pry-state，因为有时候会输出太多内容，造成刷屏。
  def pry?(caller=2, remote: nil, port: 9876)
    return unless ENV['Pry_was_started'].nil?

    require 'pry-state'
    ENV['Pry_was_started'] = 'true'

    pry3(caller, remote: remote, port: port)

    # 这里如果有代码, 将会让 pry! 进入这个方法, 因此保持为空.
  end

  # 等价于默认的 binding.pry, 会反复被拦截。
  # 起成 pry3 这个名字，也是为了方便直接使用。
  def pry3(caller=1, remote: nil, port: 9876)
    binding.of_caller(caller)._pry(remote, port)
  end

  def pry1
    ENV['Pry2_should_start'] = 'true'
  end

  # 1. 单独运行 pry2， 永远不会被拦截,
  # 2. 如果之前运行过 pry1, 此时 pry2 将被拦截, 且只会被拦截一次.

  def pry2(caller=1, remote: nil, port: 9876)
    if ENV['Pry2_should_start'] == 'true'
      # 首先恢复 Pry2_is_start 为未启动, 避免稍后的 pry2 再次被拦截.
      ENV['Pry2_should_start'] = nil
      binding.of_caller(caller)._pry(remote, port)
    end
  end

  def reirb!
    ENV['IRB_was_started'] = nil
  end

  def irb!
    return unless ENV['IRB_was_started'].nil?

    ENV['IRB_was_started'] = 'true'

    binding.of_caller(1)._irb
  end

  def irb1
    ENV['IRB2_should_start'] = 'true'
  end

  def irb2(caller=1, remote: nil, port: 9876)
    if ENV['IRB2_should_start'] == 'true'
      # 首先恢复 Pry2_is_start 为未启动, 避免稍后的 pry2 再次被拦截.
      ENV['IRB2_should_start'] = nil
      binding.of_caller(caller)._irb
    end
  end

  # 如果是前台进程，则这个进程的组ID（pgid）一定会等于当前 terminal 的gid （tpgid）
  # 否则，如果不等，那么就是后台进程。
  # system("ps -e -o pid,pgid,tpgid |grep '^\s*#{pid}' |awk '$2==$3 {exit 1}'")
  # system("\\cat /proc/#{pid}/stat |awk '$5==$8 {exit 1}'")
  def background?(pid=$$)
    # 考虑是否需要验证
    ary = File.read("/proc/#{pid}/stat").split(' ').reverse
    # 执行 reverse 再处理，是因为要考虑文件名包含空格因素。例如：‘hello) (world’
    (ary[46] != ary[48]) && !$stdout.tty?
  end

  def foreground?(pid=$$)
    not background?(pid)
  end

  def notify_send(msg)
    system("notify-send \"#{msg}\"") if system 'which notify-send &>/dev/null'

    system('aplay "#{__dir__}/drip.wav" &>/dev/null') if system 'which aplay &>/dev/null'
    warn "[1m[33m#{msg}[0m"
  end
end

# Hack roda, 在每一次发送请求之前，总是设定 ENV['Pry_was_started'] to nil.
# 这可以确保，pry! 总是会被拦截，但是仅仅只会被拦截一次。
begin
  require 'roda'
  class PryHackRodaMiddleware
    attr_reader :app

    def initialize(app)
      @app = app
    end

    def call(env)
      ENV['Pry_was_started'] = nil
      @app.call(env)
    end
  end
  Roda.use PryHackRodaMiddleware
rescue LoadError
end
