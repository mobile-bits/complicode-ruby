# frozen_string_literal: true

module Complicode
  class Invoice
    attr_accessor :nit, :amount, :issue_date, :number

    # @param [Hash] attributes of the invoice.
    # @option attributes [String] :nit
    # @option attributes [String] :number
    # @option attributes [String] :amount
    # @option attributes [String] :issue_date
    def initialize(attributes = {})
      @nit = attributes.fetch(:nit, "0").to_s
      @number = attributes.fetch(:number).to_s
      @amount = attributes.fetch(:amount).to_s.tr(",", ".").to_f.round.to_s
      @issue_date = Date.parse(attributes.fetch(:issue_date).to_s).strftime("%Y%m%d")
    end

    # @param attribute [Symbol]
    def append_checksum_digit_to(attribute)
      append_to(attribute, Verhoeff.checksum_digit_of(send(attribute)).to_s)
    end

    # @param attribute [Symbol]
    # @param value [String]
    def append_to(attribute, value)
      send("#{attribute}=", send(attribute) + value)
    end

    # @return [Integer]
    def sum
      [number, nit, issue_date, amount].map(&:to_i).inject(:+)
    end

    # @return [String]
    def concat
      [number, nit, issue_date, amount].inject(:+)
    end
  end
end
