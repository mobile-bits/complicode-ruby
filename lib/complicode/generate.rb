# frozen_string_literal: true

module Complicode
  class Generate
    # @return [String]
    def self.call(*args)
      new(*args).send(:call)
    end

    # @param authorization_code [String]
    # @param key [String]
    # @param [Hash] invoice_attributes of the invoice.
    # @option invoice_attributes [String] :nit
    # @option invoice_attributes [String] :number
    # @option invoice_attributes [String] :amount
    # @option invoice_attributes [String] :issue_date
    def initialize(authorization_code, key, invoice_attributes = {})
      @invoice = Invoice.new(invoice_attributes)
      @authorization_code = authorization_code
      @key = key
    end

    private

    # @return [String]
    def call
      partial_keys = Generators::PartialKeys.call(@key.dup, verification_digits)
      data = Generators::Data.call(@authorization_code, @invoice, partial_keys)
      encrypted_data = encrypt(data, encryption_key)
      ascii_sums = Generators::AsciiSums.call(encrypted_data, partial_keys.count)
      base64_data = Generators::Base64Data.call(ascii_sums, partial_keys)
      format(encrypt(base64_data, encryption_key))
    end

    # @return [String]
    def encryption_key
      @encryption_key ||= @key + verification_digits
    end

    # @return [String]
    def verification_digits
      @verification_digits ||= Generators::VerificationDigits.call(@invoice)
    end

    # @param data [String]
    # @param encryption_key [String]
    # @return [String]
    def encrypt(data, encryption_key)
      RC4.new(encryption_key).encrypt(data).unpack1("H*").upcase
    end

    # @param code [String]
    # @return [String]
    def format(code)
      code.scan(/.{2}/).join("-")
    end
  end
end
