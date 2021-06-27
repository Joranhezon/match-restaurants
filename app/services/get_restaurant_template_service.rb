# frozen_string_literal: true

class GetRestaurantTemplateService
  def call(name, customer_rating, distance, price, cuisine)
    restaurants = SearchRestaurantsService.new.call(name, customer_rating, distance, price, cuisine)
    SortRestaurantsService.new.call(restaurants)
  end
end
