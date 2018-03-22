class Project < ApplicationRecord
  # model association
  has_many :tasks, dependent: :destroy

  # validations
  validates_presence_of :title, :user_id
end
