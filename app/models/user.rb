# class User < ApplicationRecord
# Include default devise modules. Others available are:
# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
#       devise :database_authenticatable, :registerable,
#             :recoverable, :rememberable, :validatable,
#            :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

#    has_many :recipes, dependent: :destroy
#   has_many :favorites, dependent: :destroy
#  has_many :favorite_recipes, through: :favorites, source: :recipe

# validates :username, presence: true, uniqueness: true
# end


class User < ApplicationRecord
        # Include devise modules
        devise :database_authenticatable, :registerable,
               :recoverable, :rememberable, :validatable

        # Include devise token auth
        include DeviseTokenAuth::Concerns::User

        has_many :recipes, dependent: :destroy
        has_many :favorites, dependent: :destroy
        has_many :favorite_recipes, through: :favorites, source: :recipe

        validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
        validates :email, presence: true, uniqueness: true
end
