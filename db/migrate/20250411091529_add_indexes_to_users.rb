class AddIndexesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_index :users, [ :uid, :provider ], unique: true unless index_exists?(:users, [ :uid, :provider ])
    add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
    add_index :users, :confirmation_token, unique: true unless index_exists?(:users, :confirmation_token)
  end
end
