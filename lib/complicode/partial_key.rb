# frozen_string_literal: true

module Complicode
  PartialKey = Struct.new(:value, keyword_init: true) {
    def size
      value.size
    end
  }
end
