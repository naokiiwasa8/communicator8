class CommunityTag < ApplicationRecord
  ## Relationship
  belongs_to :tag
  belongs_to :community
end
