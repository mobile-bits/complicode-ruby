# frozen_string_literal: true

module Complicode
  module Generators
    class AsciiSums
      # @param encrypted_data [String]
      # @param partials_count [Integer]
      # @return [Struct]
      def self.call(encrypted_data, partials_count)
        Struct.new(:total, :partials).new(0, Array.new(partials_count, 0)).tap do |sums|
          encrypted_data.each_byte.with_index do |byte, index|
            sums.total += byte
            sums.partials[index % partials_count] += byte
          end
        end
      end
    end
  end
end
