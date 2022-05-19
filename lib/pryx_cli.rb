require 'clipboard'

require 'pryx/ap_hack'

# This require is needed, because can't require looksee in method when use with bundler.
# bundler remove looksee from $LOAD_PATH when start with rails.
require 'looksee'
require 'pryx/looksee_hack'

require 'pryx'

if File.exist? 'config/environment.rb'
  $LOAD_PATH.unshift('.')
  puts "\033[0;33mLoading with ./config/environment.rb ...\033[0m"
  require 'config/environment'
end
