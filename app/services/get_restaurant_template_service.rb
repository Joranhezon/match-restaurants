# frozen_string_literal: true

class GetRestaurantTemplateService
  class UnkownNameAndCuisine < StandardError; end

  def call(name = nil, customer_rating = nil, distance = nil, price = nil, cuisine = nil)
    name_or_cuisine_present?(name, cuisine)

    restaurants = SearchRestaurantsService.new.call(name, customer_rating, distance, price, cuisine)
    restaurants = SortRestaurantsService.new.call(restaurants) unless restaurants.blank?

    return_restaurants(restaurants)
  rescue UnkownNameAndCuisine => e
    message = 'Either name or cuisine arguments need to be passed'
    Rails.logger.error(e.message + message)
    message
  end

  private

  def name_or_cuisine_present?(name, cuisine)
    raise UnkownNameAndCuisine unless name.present? || cuisine.present?
  end

  def return_restaurants(restaurants)
    return 'No restaurants were found ):' if restaurants.blank?

    restaurants
  end
end
