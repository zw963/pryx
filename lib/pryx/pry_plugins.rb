require 'pry-power_assert'

require 'pry-doc'

require 'pry-yes'
Pry.commands.alias_command 'y', 'yes'

require 'pry-hier'

require 'pry-disasm'

require 'pry-aa_ancestors'
Pry::Commands.alias_command 'aa', 'aa_ancestors'

# 这个必须在最后才有效, 但是目前存在一个问题，就是会将 pry3, pry! 加入 stacks
# stack 显示 stack 的列表，frame 显示当前所在 stack, stack N 也可以根据数字跳转到 N
require 'pry-stack_explorer' # Support: up, down, bottom, top, stack, frame

Pry::Commands.block_command 'cc', 'Continue, but stop in pry! breakpoint' do
  Pry.instance_variable_set(:@initial_session, true)
  ENV['Pry_was_started'] = nil
  throw(:breakout)
end
