class Post < ApplicationRecord
  ## Relationship
  belongs_to :user, foreign_key: "user_id"
  belongs_to :community, foreign_key: "community_id"

  ## Validations
  with_options presence: true do
    validates :content
  end

  # ransack
  def self.ransackable_attributes(auth_object = nil)
    ["community_id", "content", "created_at", "id", "updated_at", "user_id"]
  end
    
end

