# frozen_string_literal: true

module Pryx
  VERSION = [0, 8, 3]

  class << VERSION
    include Comparable

    def to_s
      join('.')
    end
  end
end
