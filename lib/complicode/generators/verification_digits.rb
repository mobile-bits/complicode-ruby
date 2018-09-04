# frozen_string_literal: true

module Complicode
  module Generators
    class VerificationDigits
      DIGITS_COUNT = 5
      ITERATIONS = 2

      # @param invoice [Complicode::Invoice]
      # @return [String]
      def self.call(invoice)
        ITERATIONS.times do
          %i[number nit issue_date amount]
            .each { |attribute| invoice.append_checksum_digit_to(attribute) }
        end

        sum = invoice.sum
        DIGITS_COUNT.times { sum = Verhoeff.checksum_of(sum) }
        sum.to_s[-DIGITS_COUNT..-1]
      end
    end
  end
end
