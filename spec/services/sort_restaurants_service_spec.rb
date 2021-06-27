# frozen_string_literal: true

require 'rails_helper'

describe SortRestaurantsService do
  let(:restaurants) do
    [{
      name: 'Test',
      customer_rating: 3,
      distance: 10,
      price: 15,
      cuisine_id: 8
    }]
  end

  subject { described_class.new.call(restaurants) }

  it 'returns array of hashs' do
    expect(subject).to be_a(Array)
    expect(subject).to all(be_a(Hash))
    expect(subject).to all(have_key(:name))
    expect(subject).to all(have_key(:customer_rating))
    expect(subject).to all(have_key(:distance))
    expect(subject).to all(have_key(:price))
    expect(subject).to all(have_key(:cuisine_id))
  end

  context 'when there are less than 5 restaurants' do
    let(:restaurants) do
      [{
        name: 'Test',
        customer_rating: 3,
        distance: 15,
        price: 10,
        cuisine_id: 8
      },
       {
         name: 'Test1',
         customer_rating: 3,
         distance: 13,
         price: 10,
         cuisine_id: 8
       },
       {
         name: 'Test2',
         customer_rating: 3,
         distance: 10,
         price: 10,
         cuisine_id: 8
       },
       {
         name: 'Test3',
         customer_rating: 3,
         distance: 12,
         price: 10,
         cuisine_id: 8
       }]
    end
    let(:response) do
      [{
        name: 'Test2',
        customer_rating: 3,
        distance: 10,
        price: 10,
        cuisine_id: 8
      },
       {
         name: 'Test3',
         customer_rating: 3,
         distance: 12,
         price: 10,
         cuisine_id: 8
       },
       {
         name: 'Test1',
         customer_rating: 3,
         distance: 13,
         price: 10,
         cuisine_id: 8
       },
       {
         name: 'Test',
         customer_rating: 3,
         distance: 15,
         price: 10,
         cuisine_id: 8
       }]
    end

    it 'returns restaurants sorted by distance' do
      expect(subject).to eq(response)
    end

    context 'when two restaurants are tied by distance' do
      let(:restaurants) do
        [{
          name: 'Test',
          customer_rating: 3,
          distance: 15,
          price: 10,
          cuisine_id: 8
        },
         {
           name: 'Test1',
           customer_rating: 4,
           distance: 15,
           price: 10,
           cuisine_id: 8
         },
         {
           name: 'Test2',
           customer_rating: 3,
           distance: 10,
           price: 10,
           cuisine_id: 8
         },
         {
           name: 'Test3',
           customer_rating: 3,
           distance: 12,
           price: 10,
           cuisine_id: 8
         }]
      end
      let(:response) do
        [{
          name: 'Test2',
          customer_rating: 3,
          distance: 10,
          price: 10,
          cuisine_id: 8
        },
         {
           name: 'Test3',
           customer_rating: 3,
           distance: 12,
           price: 10,
           cuisine_id: 8
         },
         {
           name: 'Test1',
           customer_rating: 4,
           distance: 15,
           price: 10,
           cuisine_id: 8
         },
         {
           name: 'Test',
           customer_rating: 3,
           distance: 15,
           price: 10,
           cuisine_id: 8
         }]
      end

      it 'unties and sort by customer_rating' do
        expect(subject).to eq(response)
      end
    end
  end
end
