# frozen_string_literal: true

require 'rails_helper'

describe ExtractRestaurantDataService do
  describe 'call' do
    subject { described_class.new.call(path) }

    context 'when path passed is for restaurants file' do
      let(:path) { 'docs/restaurants.csv' }

      it 'returns restaurants data' do
        expect(subject).to be_a(Array)
        expect(subject.sample).to be_a(Hash)
        expect(subject.sample).to have_key(:name)
        expect(subject.sample).to have_key(:customer_rating)
        expect(subject.sample).to have_key(:distance)
        expect(subject.sample).to have_key(:price)
        expect(subject.sample).to have_key(:cuisine_id)
      end
    end

    context 'when path passed if for cuisines file' do
      let(:path) { 'docs/cuisines.csv' }

      it 'returns restaurants data' do
        expect(subject).to be_a(Array)
        expect(subject.sample).to be_a(Hash)
        expect(subject.sample).to have_key(:name)
        expect(subject.sample).to have_key(:id)
      end
    end

    context 'when parameter type is different than string' do
      let(:path) { 123 }

      it 'raises TypeError' do
        expect { subject }.to raise_error(TypeError)
      end
    end

    context 'when csv file is empty' do
      let(:path) { 'docs/unkown.csv' }
      let(:error) { ExtractRestaurantDataService::CsvEmptyError }

      before do
        allow(File)
          .to receive(:read)
          .and_return(nil)
      end

      it 'raises CsvEmptyError' do
        expect { subject }.to raise_error(error)
      end
    end
  end
end
