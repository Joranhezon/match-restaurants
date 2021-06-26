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
    expect(subject.sample).to be_a(Hash)
    expect(subject.sample).to have_key(:name)
    expect(subject.sample).to have_key(:customer_rating)
    expect(subject.sample).to have_key(:distance)
    expect(subject.sample).to have_key(:price)
    expect(subject.sample).to have_key(:cuisine_id)
  end

  it 'returns only restaurants with Delicious in its name' do
    expect(subject.sample[:name]).to include(name)
  end

  context 'when a partial and not case accurate name is passed' do
    let(:name) { 'IcIOU' }

    it 'returns only restaurants that contain IcIou in its name' do
      expect(subject.sample[:name].downcase).to include(name.downcase)
    end
  end
end
