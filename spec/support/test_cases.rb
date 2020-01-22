class TestCases
  class DateConverter
    def self.convert(value)
      Date.strptime(value, "%Y/%m/%d")
    end
  end

  class AmountConverter
    def self.convert(value)
      value.to_s.tr(",", ".").to_f
    end
  end

  def self.each(&block)
    options = {
      col_sep: "|",
      value_converters: {
        issue_date: DateConverter,
        amount: AmountConverter,
      },
    }

    SmarterCSV.process("spec/fixtures/data.csv", options).each_with_index do |row, index|
      yield(row, index + 1)
    end
  end
end
