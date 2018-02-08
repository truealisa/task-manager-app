require 'rails_helper'

RSpec.describe 'Tasks API' do
  # Initialize the test data
  let(:user) { create(:user) }
  let!(:project) { create(:project) }
  let!(:tasks) { create_list(:task, 20, project_id: project.id) }
  let(:project_id) { project.id }
  let(:id) { tasks.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /projects/:project_id/tasks
  describe 'GET /projects/:project_id/tasks' do
    before { get "/projects/#{project_id}/tasks", params: {}, headers: headers }

    context 'when project exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all project tasks' do
        expect(json.size).to eq(20)
      end
    end

    context 'when project does not exist' do
      let(:project_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Project/)
      end
    end
  end

  # Test suite for GET /projects/:project_id/tasks/:id
  describe 'GET /projects/:project_id/tasks/:id' do
    before { get "/projects/#{project_id}/tasks/#{id}", params: {}, headers: headers }

    context 'when project task exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the task' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when project task does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  # Test suite for PUT /projects/:project_id/tasks
  describe 'POST /projects/:project_id/tasks' do
    let(:valid_attributes) { { name: 'Visit Narnia', done: false }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/projects/#{project_id}/tasks", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/projects/#{project_id}/tasks", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /projects/:project_id/tasks/:id
  describe 'PUT /projects/:project_id/tasks/:id' do
    let(:valid_attributes) { { name: 'Mozart' }.to_json }

    before do
      put "/projects/#{project_id}/tasks/#{id}", params: valid_attributes, headers: headers
    end

    context 'when task exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the task' do
        updated_task = Task.find(id)
        expect(updated_task.name).to match(/Mozart/)
      end
    end

    context 'when the task does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  # Test suite for DELETE /projects/:id
  describe 'DELETE /projects/:id' do
    before { delete "/projects/#{project_id}/tasks/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
