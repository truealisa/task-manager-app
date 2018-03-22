require 'rails_helper'

RSpec.describe Project, type: :model do
  # Association test
  # ensure Project model has a 1:m relationship with the Task model
  it { should have_many(:tasks).dependent(:destroy) }
  # Validation tests
  # ensure columns title and user_id are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:user_id) }
end
