# frozen_string_literal: true

module Complicode
  PartialKey = Struct.new(:value, keyword_init: true) do
    def size
      value.size
    end
  end
end
