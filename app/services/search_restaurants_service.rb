# frozen_string_literal: true

class SearchRestaurantsService
  RESTAURANT_CSV_PATH = 'docs/restaurants.csv'
  CUISINE_CSV_PATH = 'docs/cuisines.csv'
  CUISINE_DATA = ExtractRestaurantDataService.new.call(CUISINE_CSV_PATH).freeze

  def call(name, _customer_rating, _distance, _price, cuisine)
    restaurant_data = ExtractRestaurantDataService.new.call(RESTAURANT_CSV_PATH)

    restaurant_data = search_partial_string(:name, name, restaurant_data) if name.present?
    restaurant_data = search_cuisine(cuisine, restaurant_data) if cuisine.present?

    restaurant_data
  end

  private

  def search_partial_string(key, content, data)
    data.select do |item|
      item[key].downcase.include? content.downcase
    end
  end

  def search_cuisine(cuisine, data)
    cuisine_id = get_cuisine_id(cuisine)

    data.select do |item|
      item[:cuisine_id] == cuisine_id
    end
  end

  def get_cuisine_id(cuisine)
    cuisine = CUISINE_DATA.select do |item|
      item[:name].downcase == cuisine.downcase
    end

    cuisine.first[:id]
  end
end
