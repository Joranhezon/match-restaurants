# frozen_string_literal: true

class SearchRestaurantsService
  class NoArgumentError < StandardError; end

  RESTAURANT_CSV_PATH = 'docs/restaurants.csv'
  CUISINE_CSV_PATH = 'docs/cuisines.csv'
  CUISINE_DATA = ExtractRestaurantDataService.new.call(CUISINE_CSV_PATH).freeze

  def call(name, customer_rating, distance, price, cuisine)
    raise NoArgumentError unless valid_arguments?(name, customer_rating, distance, price, cuisine)

    restaurants = ExtractRestaurantDataService.new.call(RESTAURANT_CSV_PATH)
    restaurants = search_name(name, restaurants) if name.present?
    restaurants = search_cuisine(cuisine, restaurants) if cuisine.present?
    restaurants = search_within_distance(distance, restaurants) if distance.present?
    restaurants = search_within_rating(customer_rating, restaurants) if customer_rating.present?
    restaurants = search_within_price(price, restaurants) if price.present?

    replace_cuisine_id_with_name(restaurants) unless restaurants.blank?
  end

  private

  def valid_arguments?(name, rating, distance, price, cuisine)
    name.present? || rating.present? || distance.present? || price.present? || cuisine.present?
  end

  def search_name(name, data)
    data.select do |item|
      item[:name].downcase.include? name.downcase
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
      item[:name].downcase.include? cuisine.downcase
    end

    cuisine.first[:id]
  end

  def get_cuisine_name(cuisine_id)
    cuisine = CUISINE_DATA.select do |item|
      item[:id] == cuisine_id
    end

    cuisine.first[:name]
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

  def search_within_price(price, data)
    data.select do |item|
      item[:price] <= price
    end
  end

  def replace_cuisine_id_with_name(restaurants)
    restaurants.map do |restaurant|
      cuisine = get_cuisine_name(restaurant[:cuisine_id])
      restaurant[:cuisine] = cuisine
      restaurant.delete(:cuisine_id)
    end

    restaurants
  end
end
