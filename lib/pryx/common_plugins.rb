require 'binding_of_caller'
require 'clipboard'

# ap_hack 可以确保，当使用 irb! 时，looksee ls1 输出显示正确，同时不用关闭 irb :USE_COLORIZE 设置。
# See https://github.com/oggy/looksee/issues/57
# 但是，ap_hack 必须放到 break_hack 前面，调换顺序，上面的 hack 失效。
# WARN: 下面两行代码顺序不要换。
require 'pryx/ap_hack'
require 'pryx/break_hack'
