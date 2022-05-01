require 'test_helper'
require 'pryx'

class PryxTest < Minitest::Test
  def test_looksee
    'hello'.ls1
    Kernel.instance_method(:ls1)
    Kernel.instance_method(:ls2)
    Kernel.instance_method(:_load_looksee)
  end

  def test_pry!
    Kernel.instance_method(:pry!)
    Kernel.instance_method(:repry!)
    Kernel.instance_method(:pry1)
    Kernel.instance_method(:pry2)
    Kernel.instance_method(:pry3)
    Kernel.instance_method(:pry?)
    Binding.instance_method(:_pry)
    assert_raises NameError do
      Binding.instance_method(:of_caller)
    end
  end

  def test_irb!
    Kernel.instance_method(:irb!)
    Kernel.instance_method(:reirb!)
    Kernel.instance_method(:irb1)
    Kernel.instance_method(:irb2)
    Binding.instance_method(:_irb)
  end

  def test_not_load_gems_when_require_pryx
    refute defined? Pry
    refute defined? PryRemote
    refute defined? Break
    refute defined? AwesomePrint
    refute defined? BindingOfCaller
  end
end
