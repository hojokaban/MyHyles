class CreateHyleMemories < ActiveRecord::Migration[5.2]
  def change
    create_table :hyle_memories do |t|
      t.references :hyle, foreign_key: true
      t.references :memory, foreign_key: true

      t.timestamps
    end
  end
end
