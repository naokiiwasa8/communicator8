class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :trackable
  
  ## Relationship
  has_many :communities
  has_many :posts
  has_many :favorite_communities, dependent: :destroy
  # お気に入り登録済みのcommunities
  has_many :favorited_communities, through: :favorite_communities, source: :community
  ## Validations
  with_options presence: true do
    validates :user_name
    validates :email
  end
end
