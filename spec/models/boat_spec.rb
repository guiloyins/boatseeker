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
      let(:params) { { model: 'Zxa', length: 5, longitude: '103.2210023', latitude: '42.3120905' } }

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

  describe 'scopes' do
    describe '.within' do
      let!(:boat) { create(:boat, latitude: '22.3129115', longitude: '114.2219923') }
      let!(:boat_to_far) { create(:boat, latitude: '23.3129115', longitude: '113.2219923') }

      it 'returns the near boat' do
        expect(described_class.within(22.3129115, 114.2219923, 1)).to eq([boat])
      end
    end
  end
end
