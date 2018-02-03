class Task < ApplicationRecord
  belongs_to :project

  # validation
  validates_presence_of :name
end
