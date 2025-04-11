class CreateSteps < ActiveRecord::Migration[7.2]
  def change
    create_table :steps do |t|
      t.text :instructions
      t.integer :position
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
