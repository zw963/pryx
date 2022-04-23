require 'test_helper'

class PryDisasmTest < Minitest::Test
  def test_pry_disasm
    require 'pry-disasm'

    def say_hello
      puts 'hello'
    end

    proc1 = proc { 1 + 1 }

    PryDisasm.process(method(:say_hello))
    PryDisasm.process(proc1)
    PryDisasm.process('1+1')
    assert_output "Error: The command 'disasm' requires Method/Proc/String instance.
" do
      PryDisasm.process(100)
    end

  end
end
