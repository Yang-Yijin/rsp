class Step < ApplicationRecord
  belongs_to :recipe

  validates :instructions, presence: { message: "Instructions cannot be blank" }
  validates :position, presence: { message: "Step number cannot be blank" },
          numericality: { only_integer: true, greater_than: 0, message: "Step number must be a positive number" }

  default_scope { order(position: :asc) }
end
