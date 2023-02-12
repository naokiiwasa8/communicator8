class Post < ApplicationRecord
  ## Relationship
  belongs_to :user, foreign_key: "user_id"
  belongs_to :community, foreign_key: "community_id"

  ## Validations
  with_options presence: true do
    validates :content
  end
end

