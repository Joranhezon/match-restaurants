# frozen_string_literal: true

class GetRestaurantTemplateService
  class UnkownNameAndCuisine < StandardError; end

  class InvalidArgumentTypeError < StandardError; end

  def call(name: nil, customer_rating: nil, distance: nil, price: nil, cuisine: nil)
    valid_arguments?(name, customer_rating, distance, price, cuisine)

    restaurants = SearchRestaurantsService.new.call(name, customer_rating, distance, price, cuisine)
    restaurants = SortRestaurantsService.new.call(restaurants) unless restaurants.blank?

    return_restaurants(restaurants)
  rescue UnkownNameAndCuisine => e
    message = 'Either name or cuisine arguments need to be passed'
    Rails.logger.error(e.message + message)
    message
  rescue InvalidArgumentTypeError => e
    Rails.logger.error(e.message)
    e.message
  end

  private

  def valid_arguments?(name, rating, distance, price, cuisine)
    name_or_cuisine_present?(name, cuisine)
    valid_name?(name)
    valid_rating?(rating)
    valid_distance?(distance)
    valid_price?(price)
    valid_cuisine?(cuisine)
  end

  def name_or_cuisine_present?(name, cuisine)
    raise UnkownNameAndCuisine unless name.present? || cuisine.present?
  end

  def valid_name?(name)
    raise InvalidArgumentTypeError, 'Name must be of string type' if name.present? && !name.is_a?(String)
  end

  def valid_rating?(rating)
    raise InvalidArgumentTypeError, 'Customer rating must be of int type' if rating.present? && !rating.is_a?(Integer)
  end

  def valid_distance?(distance)
    raise InvalidArgumentTypeError, 'Distance must be of int type' if distance.present? && !distance.is_a?(Integer)
  end

  def valid_price?(price)
    raise InvalidArgumentTypeError, 'Price must be of int type' if price.present? && !price.is_a?(Integer)
  end

  def valid_cuisine?(cuisine)
    raise InvalidArgumentTypeError, 'Cuisine must be of string type' if cuisine.present? && !cuisine.is_a?(String)
  end

  def return_restaurants(restaurants)
    return 'No restaurants were found ):' if restaurants.blank?

    restaurants
  end
end
