require 'test_helper'
require 'pry-disasm'

class PryDisasmTest < Minitest::Test
  def test_pry_disasm
    def say_hello
      puts 'hello'
    end

    PryDisasm.process(method(:say_hello))
  end
end
