module Pryx::Background
  # 如果是前台进程，则这个进程的组ID（pgid）一定会等于当前 terminal 的gid （tpgid）
  # 否则，如果不等，那么就是后台进程。
  # system("\\cat /proc/#{pid}/stat |awk '$5==$8 {exit 1}'")
  def self.background?(pid=$$)
    # 这个实现似乎有错, 因为针对 nohup 1.rb& 这种情况，返回为前台进程。
    # 执行 reverse 再处理，是因为要考虑文件名包含空格因素。例如：‘hello) (world’
    # ary = File.read("/proc/#{pid}/stat").split(' ').reverse
    # is_bg = (ary[46] != ary[48])

    # 这个实现依赖于一些 linux 下基本工具，但是准确
    is_bg = system("ps -e -o pid,pgid,tpgid |grep '^\s*#{pid}' |awk '$2==$3 {exit 1}'")

    is_bg && !$stdout.tty?
  end

  def self.foreground?(pid=$$)
    not background?(pid)
  end
end
