class FavoriteCommunity < ApplicationRecord
  ## Relationship
  belongs_to :user
  belongs_to :community
  ## Validations
  validates :community_id, uniqueness: { scope: :user_id }

end
