class CreateHyleDailyRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :hyle_daily_relationships do |t|
      t.references :daily_relationship, foreign_key: true
      t.references :hyle, foreign_key: true
      t.integer :relationship_amount, null: false, default: 0

      t.timestamps
    end
  end
end
