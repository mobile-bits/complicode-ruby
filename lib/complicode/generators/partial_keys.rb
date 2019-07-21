# frozen_string_literal: true

module Complicode
  module Generators
    class PartialKeys
      # @param key [String]
      # @param verification_digits [String]
      # @return [Array<Complicode::PartialKey>]
      def self.call(key, verification_digits)
        partial_key_sizes = verification_digits.split("").map { |digit| digit.to_i + 1 }
        partial_key_sizes.map do |index|
          PartialKey.new(value: key.slice!(0...index))
        end
      end
    end
  end
end
