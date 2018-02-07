require 'rails_helper'

RSpec.describe Project, type: :model do
  # Association test
  # ensure Project model has a 1:m relationship with the Task model
  it { should have_many(:tasks).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
