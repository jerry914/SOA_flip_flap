# frozen_string_literal: true

TAB = "\t"
NEWLINE = "\n"
# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    rows = tsv.split(NEWLINE).map { |row| split_tab(row) }
    headers = rows.first
    @data = rows.drop(1).map { |column| named_values(headers, column) }
  end

  def split_tab(str)
    str.chomp.split(TAB)
  end

  def named_values(headers, column)
    headers.zip(column).to_h
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    tsv_array = to_2d_tsv(@data)
    tsv_array.map { |row| row.join(TAB) + NEWLINE }.join
  end

  def to_2d_tsv(data)
    header = data.first.keys
    content = data.map(&:values)
    content.unshift(header)
  end
end
