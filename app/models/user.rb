class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :trackable
  acts_as_taggable_on :skill_tags
  ## Relationship
  has_many :communities
  has_many :posts
  has_many :favorite_communities, dependent: :destroy
  has_many :job_site_recommends
  has_many :recommended_job_sites, through: :job_site_recommends
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :feedbacks
  has_one :profile
  has_one_attached :avatar
  accepts_nested_attributes_for :profile

  # お気に入り登録済みのcommunities
  has_many :favorited_communities, through: :favorite_communities, source: :community
  # 投稿済みのcommunities
  has_many :joins_communities, through: :posts, source: :community
  ## Validations
  with_options presence: true do
    validates :user_name
    validates :email
  end

  ## Callbacks
  after_create :has_one_profile

  ## Instance Methods
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  ## Private Instance Methods
  def has_one_profile
    self.create_profile!(
      user_id: self.id,
      biography: default_biography
    )
  end

  def max_recommends_reached?
    job_site_recommends.where(recommended: true).where("created_at >= ?", Time.zone.now.beginning_of_day).count >= 5
  end
  
  def max_not_recommends_reached?
    job_site_recommends.where(recommended: false).where("created_at >= ?", Time.zone.now.beginning_of_day).count >= 5
  end

  def default_biography
    "初めまして。よろしくお願いします！"
  end

  def years_of_experience_collection
    [
      "1年未満",
      "1〜3年",
      "3〜5年",
      "5年以上",
    ]
  end
end
