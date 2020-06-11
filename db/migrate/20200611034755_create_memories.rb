class CreateMemories < ActiveRecord::Migration[5.2]
  def change
    create_table :memories do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.date :date
      t.text :description
      t.string :memory_image_id

      t.timestamps
    end
  end
end
