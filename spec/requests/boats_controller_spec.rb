# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Boat API', type: :request do
  include ActiveSupport::Testing::TimeHelpers
  describe 'POST #create' do
    let(:action) { post '/boats', params: params, xhr: true }

    context 'when all parameters are present' do
      let(:params) { { model: 'Zxa', length: 5, latitude: '103.2210023', longitude: '42.3120905' } }
      let(:expected_response) do
        {
          "id": Boat.first.id,
          "model": 'Zxa',
          "length": 5,
          "lonlat": 'POINT (103.2210023 42.3120905)',
          "created_at": '2019-05-13T05:04:44.000Z',
          "updated_at": '2019-05-13T05:04:44.000Z'
        }.to_json
      end

      before do
        travel_to Time.new(2019, 0o5, 13, 0o1, 0o4, 44)
      end

      after do
        travel_back
      end

      it 'creates the boat' do
        expect { action }.to change(Boat, :count).by(1)
      end

      it 'responds with the object saved' do
        action
        expect(response.body).to eq(expected_response)
      end
    end

    context 'when some params are missing' do
      let(:params) { { model: 'Zxa'} }
      let(:expected_response) do
        {"length":["can't be blank","is not a number"],"lonlat":["can't be blank"]}
      end

      it 'does not creates the boat' do
        expect { action }.to_not change(Boat, :count)
      end

      it 'responds with the validation error message' do
        action
        expect(response.body).to eq(expected_response.to_json)
      end
    end
  end
end
