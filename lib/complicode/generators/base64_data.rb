# frozen_string_literal: true

module Complicode
  module Generators
    class Base64Data
      BASE64 = %w[
        0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V
        W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z + /
      ].freeze

      # @param ascii_sums [Struct]
      # @param partial_keys [Array<String>]
      # @return [String]
      def self.call(ascii_sums, partial_keys)
        ascii_sums.partials.each_with_index.inject(0) do |sum, (partial_sum, index)|
          sum + ascii_sums.total * partial_sum / partial_keys[index].size
        end.b(10).to_s(BASE64)
      end
    end
  end
end
