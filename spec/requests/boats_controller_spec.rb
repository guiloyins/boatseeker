# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Boat API', type: :request do
  include ActiveSupport::Testing::TimeHelpers

  before do
    travel_to Time.new(2019, 0o5, 13, 0o1, 0o4, 44)
  end

  after do
    travel_back
  end

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

      it 'creates the boat' do
        expect { action }.to change(Boat, :count).by(1)
      end

      it 'responds with the object saved' do
        action
        expect(response.body).to eq(expected_response)
      end
    end

    context 'when some params are missing' do
      let(:params) { { model: 'Zxa' } }
      let(:expected_response) do
        { "length": ["can't be blank", 'is not a number'], "lonlat": ["can't be blank"] }
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

  describe 'GET #show' do
    let(:boat) { create(:boat) }

    context 'when the boat exists' do
      let(:expected_response) do
        {
          "id": Boat.first.id,
          "model": 'Zxa',
          "length": 5,
          "lonlat": 'POINT (103.2210023 42.3120905)',
          "created_at": '2019-05-13T05:04:44.000Z',
          "updated_at": '2019-05-13T05:04:44.000Z'
        }
      end
      before { get "/boats/#{boat.id}" }

      it 'returns the boat as expected' do
        expect(response.body).to eq(expected_response.to_json)
      end
    end

    context 'when the boat does not exists' do
      let(:expected_response) do
        {
          "error": "Couldn't find Boat with 'id'=foo"
        }
      end
      before { get '/boats/foo' }

      it 'returns the error message' do
        expect(response.body).to eq(expected_response.to_json)
      end
    end
  end

  describe 'DELETE #delete' do
    let!(:boat) { create(:boat) }

    describe 'when the boat exists' do
      let(:action) { delete "/boats/#{boat.id}" }

      it 'delete the boat' do
        expect { action }.to change(Boat, :count).by(-1)
      end

      it 'returns success' do
        action
        expect(response.status).to eq(204)
      end
    end

    describe 'when the boat does not exists' do
      let(:action) { delete '/boats/foo' }

      it 'does not delete the boat' do
        expect { action }.to_not change(Boat, :count)
      end

      it 'returns success' do
        action
        expect(response.status).to eq(404)
      end
    end
  end
end
