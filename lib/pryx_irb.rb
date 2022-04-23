# We need apply those hack before irb was loaded for work with irb.
# So we have to add it here, same hacks for Pry is add to method
# Binding#_pry which defined in lib/pryx/pry_hack.rb

# we need set `export RUBYOPT+=" -rpryx_irb"` instead of `-rpryx` to make
# irb work with break and ap gem.

require 'pryx/common_plugins'
require 'pryx'
