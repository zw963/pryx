# power_assert is ruby 3 builtin gem
require 'pry-power_assert'

require 'pry-doc'

require 'pry-yes'
Pry.commands.alias_command 'y', 'yes'

require 'pry-hier'

require 'pry-disasm'

require 'pry-aa_ancestors'
Pry::Commands.alias_command 'aa', 'aa_ancestors'

# stack 显示 stack 的列表，
# frame 显示当前所在 stack, frame N 也可以根据数字跳转到 N
require 'pry-stack_explorer'
require 'pryx/pry-stack_explorer_hack'

Pry::Commands.block_command 'cc', 'Continue, but stop in pry! breakpoint' do
  Pry.instance_variable_set(:@initial_session, true)
  ENV['Pry_was_started'] = nil
  throw(:breakout)
end
