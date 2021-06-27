# frozen_string_literal: true

require 'rails_helper'

describe SearchRestaurantsService do
  let(:name) { 'Delicious' }
  let(:customer_rating) { nil }
  let(:distance) { nil }
  let(:price) { nil }
  let(:cuisine) { nil }

  subject { described_class.new.call(name, customer_rating, distance, price, cuisine) }

  it 'returns array of hashs' do
    expect(subject).to be_a(Array)
    expect(subject).to all(be_a(Hash))
    expect(subject).to all(have_key(:name))
    expect(subject).to all(have_key(:customer_rating))
    expect(subject).to all(have_key(:distance))
    expect(subject).to all(have_key(:price))
    expect(subject).to all(have_key(:cuisine_id))
  end

  it 'returns only restaurants with Delicious in its name' do
    names = subject.map { |restaurant| restaurant[:name].downcase }
    expect(names).to all(include(name.downcase))
  end

  context 'when a partial and not case accurate name is passed' do
    let(:name) { 'IcIOU' }

    it 'returns only restaurants that contain IcIou in its name' do
      names = subject.map { |restaurant| restaurant[:name].downcase }
      expect(names).to all(include(name.downcase))
    end
  end

  context 'when cuisine is passed as argument' do
    let(:cuisine) { 'korean' }
    let(:cuisine_id) { 8 }

    it 'returns only restaurants with the name and cuisine given' do
      names = subject.map { |restaurant| restaurant[:name].downcase }
      cuisine_ids = subject.map { |restaurant| restaurant[:cuisine_id] }

      expect(cuisine_ids).to all(eq(cuisine_id))
      expect(names).to all(include(name.downcase))
    end

    context 'when no name is passed' do
      let(:name) { nil }

      it 'returns only restaurants with the given cuisine' do
        cuisine_ids = subject.map { |restaurant| restaurant[:cuisine_id] }
        expect(cuisine_ids).to all(eq(cuisine_id))
      end
    end
  end

  context 'when distance is passed as argument' do
    let(:distance) { 8 }

    it 'returns only restaurants with the given name within the distance' do
      distances = subject.map { |restaurant| restaurant[:distance] }
      expect(distances).to all(be <= distance)
    end
  end

  context 'when customer_rating is passed as argument' do
    let(:customer_rating) { 3 }

    it 'returns only restaurants with the given name within given customer rating' do
      ratings = subject.map { |restaurant| restaurant[:customer_rating] }
      expect(ratings).to all(be >= customer_rating)
    end
  end

  context 'when price is passed as argument' do
    let(:price) { 10 }

    it 'return only restaurants with the given name within price' do
      prices = subject.map { |restaurant| restaurant[:price] }
      expect(prices).to all(be <= price)
    end
  end
end
