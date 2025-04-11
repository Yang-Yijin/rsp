class User < ApplicationRecord
        # Include default devise modules. Others available are:
        # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
        devise :database_authenticatable, :registerable,
               :recoverable, :rememberable, :validatable,
               :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

        has_many :recipes, dependent: :destroy
        has_many :favorites, dependent: :destroy
        has_many :favorite_recipes, through: :favorites, source: :recipe

        validates :username, presence: true, uniqueness: true
end
