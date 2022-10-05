# frozen_string_literal: true

module Pryx
  VERSION = [0, 9, 2]

  class << VERSION
    include Comparable

    def to_s
      join('.')
    end
  end
end
