class CreateHyles < ActiveRecord::Migration[5.2]
  def change
    create_table :hyles do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.string :name, null: false
      t.date :birthday
      t.boolean :birthday_added, null: false, default: false
      t.integer :total_relationship, default: 0
      t.string :hyle_image_id

      t.timestamps
    end
  end
end
