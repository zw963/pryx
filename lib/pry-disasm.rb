# frozen_string_literal: true

require 'pry'
require 'pry-disasm/commands'
require 'pry-disasm/version'

class PryDisasm
  def self.process(expr)
    str = RubyVM::InstructionSequence.disasm(expr)

    lines = str.split("\n")
    lines[0].gsub!(/=+/) { |s| "\033[0;32m#{s}\033[0m" }
    lines[0].gsub!(/<(.*?)@(.*?)>/) { "<\033[0;33m#{$1}\033[0m@\033[0;33m#{$2}\033[0m>" }

    (1..lines.length).each do |i|
      lines[i] = "\033[0;35m#{lines[i]}\033[0m"
      lines[i].gsub!(/^(.*?)(\s+)(.*?)(\s+)/) { "#{$1}#{$2}\033[0;36m#{$3}\033[0m#{$4}" }
      lines[i].gsub!(/<(.*?):(.*?)>/) { "<\033[0;34m#{$1}\033[0m#:#{$2}>" }
    end

    puts lines
  end
end
