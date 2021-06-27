# frozen_string_literal: true

class GetRestaurantTemplateService
  class UnkownNameAndCuisine < StandardError; end

  def call(name = nil, customer_rating = nil, distance = nil, price = nil, cuisine = nil)
    is_name_or_cuisine_present?(name, cuisine)

    restaurants = SearchRestaurantsService.new.call(name, customer_rating, distance, price, cuisine)
    SortRestaurantsService.new.call(restaurants)
  rescue UnkownNameAndCuisine => e
    message = 'Either name or cuisine arguments need to be passed'
    Rails.logger.error(e.message + message)
    message
  end

  private

  def name_or_cuisine_present?(name, cuisine)
    raise UnkownNameAndCuisine unless name.present? || cuisine.present?
  end
end
