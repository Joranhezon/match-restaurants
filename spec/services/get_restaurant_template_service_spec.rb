# frozen_string_literal: true

require 'rails_helper'

describe GetRestaurantTemplateService do
  let(:name) { 'Delicious' }
  let(:customer_rating) { nil }
  let(:distance) { nil }
  let(:price) { nil }
  let(:cuisine) { nil }

  subject { described_class.new.call(name, customer_rating, distance, price, cuisine) }

  it 'returns up to 5 restaurants with Delicious on their name' do
    expect(subject).to be_a(Array)
    expect(subject.length).to be <= 5
    expect(subject).to all(be_a(Hash))
    expect(subject).to all(have_key(:name))
    expect(subject).to all(have_key(:customer_rating))
    expect(subject).to all(have_key(:distance))
    expect(subject).to all(have_key(:price))
    expect(subject).to all(have_key(:cuisine_id))
  end
end
