# frozen_string_literal: true

module Complicode
  class Invoice
    attr_reader :nit, :amount, :issue_date, :number

    # @param [Integer] :nit
    # @param [Integer] :number
    # @param [Float] :amount
    # @param [Date] :issue_date
    def initialize(nit:, number:, issue_date:, amount:)
      @amount = Float(amount)
      @nit = Integer(nit)
      @number = Integer(number)
      @issue_date = Date.parse(issue_date.to_s)
    end
  end
end
