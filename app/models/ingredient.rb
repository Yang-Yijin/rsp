class Ingredient < ApplicationRecord
  belongs_to :recipe

  validates :name, presence: { message: "Ingredient name cannot be blank" }
  validates :quantity, presence: { message: "Quantity cannot be blank" }
end
