class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  # 确保每个用户只能收藏一个食谱一次
  validates :user_id, uniqueness: { scope: :recipe_id, message: "已经收藏了这个食谱" }
end
