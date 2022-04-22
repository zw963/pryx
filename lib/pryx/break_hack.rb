require 'break'
load "#{__dir__}/../break/pry/extensions.rb"

Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'w', 'watch' # watch is pry builtin
