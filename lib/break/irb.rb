# frozen_string_literal: true

require_relative "irb/frontend"
require_relative "irb/commands"
require_relative "irb/overrides"

require "open-uri"

Break::Filter.register_internal IRB.method(:start).source_location.first.chomp(".rb")
Break::Filter.register_internal URI.method(:open).source_location.first.chomp(".rb")
Break::Filter.register_internal "(irb)"

Binding.prepend Break::IRB::Overrides
