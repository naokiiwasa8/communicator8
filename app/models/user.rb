class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  ## Relationship
  has_many :communities
  has_many :posts
  has_many :favorite_communities, dependent: :destroy
  has_many :communities, through: :favorite_communities
  ## Validations
  with_options presence: true do
    validates :user_name
    validates :email
  end
end
