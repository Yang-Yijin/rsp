class UpdateExistingUsersForDeviseTokenAuth < ActiveRecord::Migration[6.1]
  def up
    User.reset_column_information
    User.find_each do |user|
      user.uid = user.email if user.uid.blank?
      user.provider = 'email' if user.provider.blank?
      user.save!
    end
  end

  def down
    # 不需要向下迁移操作
  end
end
