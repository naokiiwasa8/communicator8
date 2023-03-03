class Tag < ApplicationRecord
  ## Relationship
  has_many :community_tags
  has_many :communities, through: :community_tags
  ## Validations
  with_options presence: true do
    validates :name
  end
end
