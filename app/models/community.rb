class Community < ApplicationRecord

  ## Relationship
  has_many :posts
  belongs_to :user, foreign_key: "user_id"

  ## Validations
  with_options presence: true do
    validates :community_name
  end
  
end
