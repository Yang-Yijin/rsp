class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user

  validates :title, presence: { message: "Title cannot be blank" },
          length: { minimum: 3, maximum: 100, message: "Title must be between 3-100 characters" }

  validates :description, presence: { message: "Description cannot be blank" }

  validates :cook_time, presence: { message: "Cooking time cannot be blank" },
          numericality: { only_integer: true, greater_than: 0, message: "Cooking time must be a positive number" }
  # 允许嵌套表单
  accepts_nested_attributes_for :ingredients,
                               allow_destroy: true,
                               reject_if: proc { |attrs| attrs["name"].blank? || attrs["quantity"].blank? }

  accepts_nested_attributes_for :steps,
                               allow_destroy: true,
                               reject_if: proc { |attrs| attrs["instructions"].blank? || attrs["position"].blank? }
end
