require 'test_helper'
require 'pryx_irb'
require 'pryx/pry_plugins'

class PryxTest < Minitest::Test
  def test_common_plugins
    assert_nil ap([1, 2, 3])
    Binding.instance_method(:of_caller)
  end

  def test_loaded_pry_plugins_when_invoke_pry!
    assert PryDoc
    assert PryPowerAssert
    assert PryYes
    assert TTY::Tree # pry-hier
    String.instance_method(:surround) # pry-aa_ancestors
    assert PryStackExplorer
    assert PryDisasm
  end
end
