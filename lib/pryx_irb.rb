# We need apply those hack before irb was loaded for work with irb.
# So we have to add it here, same hacks for Pry is add to method
# Binding#_pry which defined in lib/pryx/pry_hack.rb

# we need set `export RUBYOPT+=" -rpryx_irb"` instead of `-rpryx` to make
# irb work with break and ap gem.

# ap_hack 可以确保，当时用 irb! 的时候，输入代码是彩色的，并且 looksee 也正常显示
# 但是，ap_hack 不可以放到 break_hack 后面，否则会失效。
# WARN: 下面两行代码顺序不要换。
require 'pryx/ap_hack'
require 'pryx/break_hack'

require 'pryx'
