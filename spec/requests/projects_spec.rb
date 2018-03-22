require 'rails_helper'

RSpec.describe 'Projects API', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let!(:projects) { create_list(:project, 10, user_id: user.id) }
  let(:project_id) { projects.first.id }
  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /api/projects
  describe 'GET /api/projects' do
    # make HTTP get request before each example
    before { get '/api/projects', params: {}, headers: headers }

    it 'returns projects' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/projects/:id
  describe 'GET /api/projects/:id' do
    before { get "/api/projects/#{project_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the project' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(project_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:project_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Project/)
      end
    end
  end

  # Test suite for POST /api/projects
  describe 'POST /api/projects' do
    let(:valid_attributes) do
      # send json payload
      { title: 'Learn Elm', user_id: user.id.to_s }.to_json
    end

    context 'when the request is valid' do
      before { post '/api/projects', params: valid_attributes, headers: headers }

      it 'creates a project' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post '/api/projects', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # Test suite for PUT /api/projects/:id
  describe 'PUT /api/projects/:id' do
    let(:valid_attributes) { { title: 'Shopping' }.to_json }

    context 'when the record exists' do
      before { put "/api/projects/#{project_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /api/projects/:id
  describe 'DELETE /api/projects/:id' do
    before { delete "/api/projects/#{project_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
