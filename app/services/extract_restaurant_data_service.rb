# frozen_string_literal: true

require 'csv'

class ExtractRestaurantDataService
  class CsvEmptyError < StandardError; end

  def call(path)
    raise TypeError unless path.is_a?(String)

    restaurant_data = CSV.new(
      File.read(path),
      headers: true,
      header_converters: :symbol,
      converters: :all
    )

    restaurant_data.to_a.map(&:to_h)
  rescue ArgumentError => e
    Rails.logger.error e
    raise CsvEmptyError
  end
end
