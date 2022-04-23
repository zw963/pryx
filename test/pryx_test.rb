require 'pryx_irb'

class PryxTest < Minitest::Test
  def test_looksee
    "hello".ls1
  end

  def test_pry!
    assert Kernel.method(:pry!)
    assert Kernel.method(:repry!)
    assert Kernel.method(:pry1)
    assert Kernel.method(:pry2)
    assert Kernel.method(:pry3)
    assert Kernel.method(:pry?)
    assert Binding.instance_method(:_pry)
  end

  def test_irb!
    assert Kernel.method(:irb!)
    assert Kernel.method(:reirb!)
    assert Kernel.method(:irb1)
    assert Kernel.method(:irb2)
    assert Binding.instance_method(:_irb)
  end
end
