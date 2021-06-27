# frozen_string_literal: true

class SortRestaurantsService
  def call(restaurants)
    sort_by_distance(restaurants)
  end

  private

  def sort_by_distance(restaurants)
    restaurants.sort_by do |restaurant|
      restaurant[:distance]
    end
  end
end
