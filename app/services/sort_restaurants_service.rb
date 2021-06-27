# frozen_string_literal: true

class SortRestaurantsService
  def call(restaurants)
    restaurants = sort_by_distance(restaurants)
    untie_sort_by_rating(restaurants)
  end

  private

  def sort_by_distance(restaurants)
    restaurants.sort_by do |restaurant|
      restaurant[:distance]
    end
  end

  def untie_sort_by_rating(restaurants)
    restaurants.each_with_index do |element, index|
      next unless restaurants[index + 1].present? && untie_by_rating?(element, restaurants[index + 1])

      temp = element
      restaurants[index] = restaurants[index + 1]
      restaurants[index + 1] = temp
    end
  end

  def untie_by_rating?(first_restaurant, second_restaurant)
    first_restaurant[:distance] == second_restaurant[:distance] &&
      second_restaurant[:customer_rating] > first_restaurant[:customer_rating]
  end
end
