# frozen_string_literal: true

module Pryx
  VERSION = [0, 10, 1]

  class << VERSION
    include Comparable

    def to_s
      join('.')
    end
  end
end
