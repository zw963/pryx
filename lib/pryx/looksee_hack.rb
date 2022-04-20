# ls1 支持的参数有：
# - String 或　Regexp，包含字符串或匹配正则过滤.
# - :nopublic :noprotected, :noprivate, :noundefined, :nooverridden 显示指定类型方法．
# 颜色方案
# 模块 白色 37
# 公开方法 绿色 32
# 保护方法 黄色 33
# 私有方法 红色 31
# 取消定义的方法 蓝色 34
# 被覆写的方法 灰色 30

module Kernel
  def load_looksee
    case RbConfig::CONFIG['ruby_version']
    when '1.9.0'...'2.1.0'
      require 'old_looksee'
    when '2.1.0'...'3.2.0'
      require 'looksee'
    end
    Looksee.rename :ls_looksee

    Looksee.editor = '.emacsclient +%l %f' # e.g. [].ls1.edit :to_set
  end

  def ls1(*args)
    load_looksee unless defined? Looksee
    Looksee[self, *args, :noprivate]
  end

  def ls2(*args)
    load_looksee unless defined? Looksee
    Looksee[self, *args]
  end
end
