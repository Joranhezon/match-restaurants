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
  end
end
