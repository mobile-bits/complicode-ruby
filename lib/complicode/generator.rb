# frozen_string_literal: true

module Complicode
  class Generator
    BASE64 = %w[
      0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V
      W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z + /
    ].freeze

    # @param authorization_code [String]
    # @param key [String]
    # @param invoice [Complicode::Invoice]
    # @return [String]
    def call(authorization_code:, key:, invoice:)
      key.freeze

      seeds = [
        invoice.number.to_s,
        invoice.nit.to_s,
        invoice.issue_date.strftime("%Y%m%d"),
        invoice.amount.round.to_s,
      ]

      seeds = append_verification_digits(seeds, 2)
      digits = generate_verification_digits(seeds)
      partial_keys = generate_partial_keys(key.dup, digits)

      seeds.unshift(authorization_code)
      seeds = append_partial_keys(seeds, partial_keys)

      encryption_key = key + digits
      encrypted_data = encrypt(seeds.join, encryption_key)

      ascii_sums = generate_ascii_sums(encrypted_data, partial_keys.count)
      base64_data = generate_base64_data(ascii_sums, partial_keys)

      format(encrypt(base64_data, encryption_key))
    end

    def append_verification_digits(seed, count)
      case seed
      when Array
        seed.map { |seed| append_verification_digits(seed, count) }
      else
        count.times do
          seed = seed.to_s + Verhoeff.checksum_digit_of(seed).to_s
        end

        seed
      end
    end

    # @param invoice [Array<String>]
    # @return [String]
    def generate_verification_digits(seeds)
      sum = seeds.map(&:to_i).sum
      sum = append_verification_digits(sum, 5)
      sum.to_s[-5..-1]
    end

    # @param key [String]
    # @param digits [String]
    # @return [Array<Complicode::PartialKey>]
    def generate_partial_keys(key, digits)
      partial_key_sizes = digits.split("").map { |digit| digit.to_i + 1 }
      partial_key_sizes.map { |index| PartialKey.new(value: key.slice!(0...index)) }
    end

    def append_partial_keys(seeds, partial_keys)
      seeds.map.with_index { |seed, index| seed + partial_keys[index].value }
    end

    # @param encrypted_data [String]
    # @param partials_count [Integer]
    # @return [Struct]
    def generate_ascii_sums(data, partials_count)
      Struct.new(:total, :partials).new(0, Array.new(partials_count, 0)).tap do |sums|
        data.each_byte.with_index do |byte, index|
          sums.total += byte
          sums.partials[index % partials_count] += byte
        end
      end
    end

    # @param ascii_sums [Struct]
    # @param partial_keys [Array<String>]
    # @return [String]
    def generate_base64_data(ascii_sums, partial_keys)
      ascii_sums.partials.each_with_index.inject(0) { |sum, (partial_sum, index)|
        sum + ascii_sums.total * partial_sum / partial_keys[index].size
      }.b(10).to_s(BASE64)
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
