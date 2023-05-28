class Community < ApplicationRecord
  acts_as_taggable_on :community_tags

  ## Relationship
  has_many :posts
  has_many :favorite_communities, dependent: :destroy
  has_many :favoriting_users, through: :favorite_communities, source: :user
  belongs_to :user, foreign_key: "user_id"

  # communituyに対して投稿したUserの人数を取得
  has_many :posting_users, through: :posts, source: :user

  ## Validations
  with_options presence: true do
    validates :community_name
  end

  # ransack
  def self.ransackable_attributes(auth_object = nil)
    ["community_name", "created_at", "id", "updated_at", "user_id"]
  end

  def favorited_by?(user)
    favoriting_users.include?(user)
  end
end
