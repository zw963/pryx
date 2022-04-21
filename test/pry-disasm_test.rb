require 'pry-disasm'

class PryDisasmTest < Minitest::Test
  def test_ok
    def say_hello
      puts 'hello'
    end

    PryDisasm.process(method(:say_hello))
  end
end
