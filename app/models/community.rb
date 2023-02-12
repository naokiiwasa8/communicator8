class Community < ApplicationRecord

  ## Relationship
  has_many :posts

  ## Validations
  with_options presence: true do
    validates :community_name
  end
  
end
