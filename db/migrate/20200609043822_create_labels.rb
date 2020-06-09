class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.references :hyle, foreign_key: true
      t.string :name, null: false
      t.text :body

      t.timestamps
    end
  end
end
