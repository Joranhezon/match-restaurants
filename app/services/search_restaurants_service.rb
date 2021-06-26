# frozen_string_literal: true

class SearchRestaurantsService
  RESTAURANT_CSV_PATH = 'docs/restaurants.csv'
  CUISINE_CSV_PATH = 'docs/cuisines.csv'
  CUISINE_DATA = ExtractRestaurantDataService.new.call(CUISINE_CSV_PATH).freeze

  def call(name, customer_rating, distance, price, cuisine)
    restaurant_data = ExtractRestaurantDataService.new.call(RESTAURANT_CSV_PATH)
    restaurant_data = search_partial_string(:name, name, restaurant_data) if name.present?
  end

  private

  def search_partial_string(key, content, data)
    data.select do |item|
      item[key].downcase.include? content.downcase
    end
  end
end
