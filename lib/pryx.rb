# frozen_string_literal: true

require 'pryx/version'
require 'pryx/background'
require 'pryx/trap_backtrace'
require 'pryx/looksee_hack'
require 'pryx/pry_hack'
require 'pryx/irb_hack'

# Add the non-bundler managermented gems back
# this step is necessory when install pryx in docker-compose
ENV['RUBYLIB'] = "#{ENV['RUBYLIB']}:#{$LOAD_PATH.grep(/gems/).join(':')}"

# set export RUBYOPT+=" -rpryx" to work with pryx.
module Pryx
end
