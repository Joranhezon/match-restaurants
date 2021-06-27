# frozen_string_literal: true

class SearchRestaurantsService
  RESTAURANT_CSV_PATH = 'docs/restaurants.csv'
  CUISINE_CSV_PATH = 'docs/cuisines.csv'
  CUISINE_DATA = ExtractRestaurantDataService.new.call(CUISINE_CSV_PATH).freeze

  def call(name, customer_rating, distance, _price, cuisine)
    restaurants = ExtractRestaurantDataService.new.call(RESTAURANT_CSV_PATH)

    restaurants = search_partial_string(:name, name, restaurants) if name.present?
    restaurants = search_cuisine(cuisine, restaurants) if cuisine.present?
    restaurants = search_within_distance(distance, restaurants) if distance.present?
    restaurants = search_within_rating(customer_rating, restaurants) if customer_rating.present?

    restaurants
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

  def search_within_distance(distance, data)
    data.select do |item|
      item[:distance] <= distance
    end
  end

  def search_within_rating(rating, data)
    data.select do |item|
      item[:customer_rating] >= rating
    end
  end
end
