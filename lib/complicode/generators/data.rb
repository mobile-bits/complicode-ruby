# frozen_string_literal: true

module Complicode
  module Generators
    class Data
      # @param authorization_code [String]
      # @param invoice [Complicode::Invoice]
      # @param partial_keys [Array<Complicode::PartialKey>]
      # @return [String]
      def self.call(authorization_code, invoice, partial_keys)
        authorization_code += partial_keys[0].value

        %i[number nit issue_date amount].each.with_index(1) do |attribute, index|
          invoice.append_to(attribute, partial_keys[index].value)
        end

        authorization_code + invoice.concat
      end
    end
  end
end
