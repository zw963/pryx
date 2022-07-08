# power_assert is ruby 3 builtin gem
require 'pry-power_assert' # Add command `pa`

require 'pry-doc' # Add two commands, `$` for show source, `?` for show documentation.

require 'pry-yes' # Add command `yes`

require 'pry-hier' # Add command `hier`

require 'pry-disasm' # Add command `disasm`

require 'pry-aa_ancestors' # Add command `aa`
Pry::Commands.alias_command 'aa', 'aa_ancestors'

# stack 显示 stack 的列表，
# frame 显示当前所在 stack, frame N 也可以根据数字跳转到 N
require 'pry-stack_explorer' # Add command `up/down/frame[n]/stack`
require 'pryx/pry-stack_explorer_hack'

# Add command `cc`
Pry::Commands.block_command 'cc', 'Continue, but stop in pry! breakpoint' do
  Pry.instance_variable_set(:@initial_session, true)
  ENV['Pry_was_started'] = nil
  throw(:breakout)
end

Pry.commands.alias_command 'wai', 'whereami' # Add command alias `wai`

# Hit Enter repeat last command
Pry::Commands.command(/^$/, 'repeat last command') do
  pry_instance.run_command Pry.history.to_a.last
end
