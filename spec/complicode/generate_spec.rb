# frozen_string_literal: true

require "spec_helper"

RSpec.describe Complicode::Generate do
  describe ".call" do
    subject { described_class.call(authorization_code, key, invoice_attributes) }

    let(:authorization_code) { "29040011007" }
    let(:key) { "9rCB7Sv4X29d)5k7N%3ab89p-3(5[A" }
    let(:invoice_attributes) do
      { nit: "4189179011", number: "1503", issue_date: "20070702", amount: "2500" }
    end

    it { is_expected.to eq "6A-DC-53-05-14" }

    SmarterCSV.process("spec/fixtures/data.csv", col_sep: "|").each.with_index(1) do |row, index|
      context "with sample data ##{index}" do
        let(:authorization_code) { row[:authorization_code].to_s }
        let(:invoice_attributes) { row.slice(:nit, :issue_date, :number, :amount) }
        let(:key) { row[:key].to_s }

        it { is_expected.to eq row[:control_code] }
      end
    end
  end
end
