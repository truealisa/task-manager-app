require 'rails_helper'

# Test suite for the Item model
RSpec.describe Task, type: :model do
  # Association test
  # ensure a task record belongs to a single project record
  it { should belong_to(:project) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end
