# frozen_string_literal: true

require "spec_helper"

RSpec.describe Complicode::Generator do
  describe "#call" do
    subject { described_class.new.call(authorization_code: authorization_code, key: key, invoice: invoice) }

    let(:authorization_code) { "29040011007" }
    let(:key) { "9rCB7Sv4X29d)5k7N%3ab89p-3(5[A" }
    let(:invoice) do
      Complicode::Invoice.new(nit: 4189179011, number: 1503, issue_date:  Date.new(2007, 7, 2), amount: 2500.0)
    end

    it { is_expected.to eq "6A-DC-53-05-14" }

    TestCases.each do |row, index|
      context "with sample data ##{index}" do
        let(:authorization_code) { row[:authorization_code].to_s }
        let(:key) { row[:key].to_s }
        let(:invoice) { Complicode::Invoice.new(row.slice(:nit, :issue_date, :number, :amount)) }

        it { is_expected.to eq row[:control_code] }
      end
    end
  end
end
