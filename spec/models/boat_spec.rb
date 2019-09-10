# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Boat, type: :model do
  describe 'validations' do
    %i[model length lonlat].each do |params|
      it { is_expected.to validate_presence_of(params) }
    end

    it { is_expected.to validate_numericality_of(:length).is_greater_than(0) }
  end

  describe 'set_location' do
    let(:boat) { described_class.new(params) }

    context 'with latitude and longitude' do
      let(:params) { { model: 'Zxa', length: 5, latitude: '103.2210023', longitude: '42.3120905' } }
      it 'sets the lonlat field with the lat and lon' do
        boat.save
        expect(boat.lonlat.to_s).to eq('POINT (103.2210023 42.3120905)')
      end
    end

    context 'with latitude and longitude' do
      let(:params) { { model: 'Zxa', length: 5 } }
      it 'sets the lonlat field with the lat and lon' do
        expect(boat.save).to eq false
      end
    end
  end
end
