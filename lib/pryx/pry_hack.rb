# 注意如果开启 pry-stack_explorer, 就不要使用 debugger, 因为进入新的上下文后, pry-stack_explorer 将失效.

class Binding
  def _pry(host=nil, port=nil, options={})
    if host
      require 'pry-remote'
    else
      require 'pry'
    end

    require 'pryx/common_plugins'
    require 'pryx/pry_plugins'

    if host
      notify_send('loading remote pry ...')
      # remote_pry(host, port, options) if Pry.initial_session?
      remote_pry(host, port, options)
    else
      warn '[1m[33mloading pry ...[0m'
      self.pry
    end
  end
end

module Kernel
  # 运行 pry! 会被拦截, 且只会被拦截一次.
  def pry!(remote: nil, port: 9876)
    return unless ENV['Pry_was_started'].nil?

    ENV['Pry_was_started'] = 'true'

    pry3(2, remote: remote, port: port)

    # 这里如果有代码, 将会让 pry! 进入这个方法, 因此保持为空.
  end

  # 在 pry! 之前如果输入这个，会让下次执行的 pry! 被拦截一次， 而不管之前是否有执行过 pry!
  def repry!
    ENV['Pry_was_started'] = nil
  end

  # 和 pry! 的差别就是，pry? 使用 pry-state 插件输出当前 context 的很多变量内容。
  # 注意：不需要总是开启 pry-state，因为有时候会输出太多内容，造成刷屏。
  def pry?(remote: nil, port: 9876)
    return unless ENV['Pry_was_started'].nil?

    require 'pry-state'
    ENV['Pry_was_started'] = 'true'

    pry3(2, remote: remote, port: port)

    # 这里如果有代码, 将会让 pry! 进入这个方法, 因此保持为空.
  end

  def pry1
    ENV['Pry2_should_start'] = 'true'
  end

  # 1. 单独运行 pry2， 永远不会被拦截,
  # 2. 如果之前运行过 pry1, 此时 pry2 将被拦截, 且只会被拦截一次.

  def pry2(remote: nil, port: 9876)
    if ENV['Pry2_should_start'] == 'true'
      ENV['Pry2_should_start'] = nil
      pry3(2, remote: remote, port: port)
    end
  end

  # 等价于默认的 binding.pry, 会反复被拦截。
  # 起成 pry3 这个名字，也是为了方便直接使用。
  def pry3(caller=1, remote: nil, port: 9876)
    remote = '0.0.0.0' if Pryx::Background.background?

    require 'binding_of_caller'

    binding.of_caller(caller)._pry(remote, port)
  end

  def notify_send(msg)
    system("notify-send \"#{msg}\"") if system 'which notify-send &>/dev/null'

    system('aplay "#{__dir__}/drip.wav" &>/dev/null') if system 'which aplay &>/dev/null'
    warn "[1m[33m#{msg}[0m"
  end
end

# Hack for roda/rails, 在每一次发送请求之前，总是设定 ENV['Pry_was_started'] to nil.
# 这可以确保，pry! 总是会被拦截，但是仅仅只会被拦截一次。

class Pryx::PryHackForRodaRailsMiddleware
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    ENV['Pry_was_started'] = nil
    @app.call(env)
  end
end

begin
  require 'roda'
  Roda.use Pryx::PryHackForRodaRailsMiddleware
rescue LoadError
end

begin
  require 'active_support/lazy_load_hooks'
  ActiveSupport.on_load(:before_configuration) do
    # because exits less command error when use in container, use irb instead.
    # require 'pry'
    # require 'pryx'
    # Rails.application.config.console = Pry
    Rails.application.config.middleware.use Pryx::PryHackForRodaRailsMiddleware
  end
rescue LoadError
end
