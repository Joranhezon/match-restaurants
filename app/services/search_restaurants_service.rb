# frozen_string_literal: true

class SearchRestaurantsService
  RESTAURANT_CSV_PATH = 'docs/restaurants.csv'
  CUISINE_CSV_PATH = 'docs/cuisines.csv'
  RESTAURANT_DATA = ExtractRestaurantDataService.new.call(RESTAURANT_CSV_PATH).freeze
  CUISINE_DATA = ExtractRestaurantDataService.new.call(CUISINE_CSV_PATH).freeze

  def call(name, customer_rating, distance, price, cuisine)
    response = search_partial_string(:name, name, RESTAURANT_DATA) if name.present?
  end

  private

  def search_partial_string(key, content, data)
    data.map do |item|
      item if item[key].downcase.include? content.downcase
    end.compact
  end
end
