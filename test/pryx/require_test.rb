require 'test_helper'
require "power_assert"
require "binding_of_caller"
require "awesome_print"
require "power_assert"
require "clipboard"
require "coderay"
require "method_source"
require "pry-doc"

class PryxTest < Minitest::Test
  def test_require_successful
    Binding.instance_method(:of_caller)

    assert defined? AwesomePrint
    assert defined? BindingOfCaller
    assert defined? PowerAssert
    assert defined? Clipboard
    assert defined? CodeRay
    assert defined? MethodSource
    assert defined? PryDoc
  end
end
