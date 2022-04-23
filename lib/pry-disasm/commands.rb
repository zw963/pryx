# frozen_string_literal: true

Pry::Commands.create_command 'disasm' do
  description 'Pry plugin that displays YARV bytecode for a method or expression. '
  command_options argument_required: true
  group 'Context'

  def process
    expr = target.eval(arg_string)
    PryDisasm.process(expr)
  end
end
