# frozen_string_literal: true

require 'rails_helper'

describe GetRestaurantTemplateService do
  let(:name) { 'Delicious' }
  let(:customer_rating) { nil }
  let(:distance) { nil }
  let(:price) { nil }
  let(:cuisine) { nil }

  subject do
    described_class.new.call(
      name: name,
      customer_rating: customer_rating,
      distance: distance,
      price: price,
      cuisine: cuisine
    )
  end

  it 'returns up to 5 restaurants with Delicious on their name' do
    expect(subject).to be_a(Array)
    expect(subject.length).to be <= 5
    expect(subject).to all(be_a(Hash))
    expect(subject).to all(have_key(:name))
    expect(subject).to all(have_key(:customer_rating))
    expect(subject).to all(have_key(:distance))
    expect(subject).to all(have_key(:price))
    expect(subject).to all(have_key(:cuisine))
  end

  context 'when no restaurants are found' do
    let(:name) { 'Does not exist' }
    let(:message) { 'No restaurants were found ):' }

    it 'returns message stating that no restaurants were found' do
      expect(subject).to eq(message)
    end
  end

  context 'when invalid arguments are passed' do
    context 'when neither name nor cuisine are passed' do
      let(:name) { nil }
      let(:message) { 'Either name or cuisine arguments need to be passed' }

      it 'returns message stating that name or cuisine need to be passed' do
        expect(subject).to eq(message)
      end
    end

    context 'when name is of an invalid type' do
      let(:name) { 123 }
      let(:message) { 'Name must be of string type' }

      it 'returns message stating that name is of invalid Argument' do
        expect(subject).to eq(message)
      end
    end

    context 'when customer_rating is of an invalid type' do
      let(:customer_rating) { 'rating' }
      let(:message) { 'Customer rating must be of int type' }

      it 'returns message stating that rating is of invalid Argument' do
        expect(subject).to eq(message)
      end
    end

    context 'when distance is of an invalid type' do
      let(:distance) { 'distance' }
      let(:message) { 'Distance must be of int type' }

      it 'returns message stating that distance is of invalid Argument' do
        expect(subject).to eq(message)
      end
    end

    context 'when price is of an invalid type' do
      let(:price) { 'price' }
      let(:message) { 'Price must be of int type' }

      it 'returns message stating that price is of invalid Argument' do
        expect(subject).to eq(message)
      end
    end

    context 'when cuisine is of an invalid type' do
      let(:cuisine) { 8 }
      let(:message) { 'Cuisine must be of string type' }

      it 'returns message stating that cuisine is of invalid Argument' do
        expect(subject).to eq(message)
      end
    end
  end
end
