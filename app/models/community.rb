class Community < ApplicationRecord

  ## Relationship
  has_many :posts
  # has_many :community_tags
  # has_many :tags, through: :community_tags
  belongs_to :user, foreign_key: "user_id"

  # communituyに対して投稿したUserの人数を取得
  has_many :posting_users, through: :posts, source: :user

  ## Validations
  with_options presence: true do
    validates :community_name
  end
  
  
end
