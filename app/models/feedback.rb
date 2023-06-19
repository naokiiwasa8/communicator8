class Feedback < ApplicationRecord
  ## Relationship
  belongs_to :user

  ## Validations
  with_options presence: true do
    validates :subject
    validates :content
  end
end
