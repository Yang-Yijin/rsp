class CreateRecipes < ActiveRecord::Migration[7.2]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.integer :cook_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
