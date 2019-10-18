# spec/requests/categories_spec.rb
require 'rails_helper'

RSpec.describe 'Test API', type: :request do
  # initialize test data
  let!(:categories) { create_list(:category, 10) }
  let(:categories_id) { categories.first.id }

  # Test suite for GET /categories
  describe 'GET /categories' do
    # make HTTP get request before each example
    before { get '/categories' }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /categories/:id
  describe 'GET /categories/:id' do
    before { get "/categories/#{categories_id}" }

    context 'when the record exists' do
      it 'returns the categories' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(categories_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:categories_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/message\":\"Couldn't find Category with 'id'=100/)
      end
    end
  end

  # Test suite for POST /categories
  describe 'POST /categories' do
    # valid payload
    let(:valid_attributes) { { name: 'Learn Elm' } }

    context 'when the request is valid' do
      before { post '/categories', params: valid_attributes }

      it 'creates a categories' do
        expect(json['name']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/categories', params: { name: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /categories/:id
  describe 'PUT /categories/:id' do
    let(:valid_attributes) { { name: 'Shopping' } }

    context 'when the record exists' do
      before { put "/categories/#{categories_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /categories/:id
  describe 'DELETE /categories/:id' do
    before { delete "/categories/#{categories_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end