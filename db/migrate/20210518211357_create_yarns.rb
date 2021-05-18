class CreateYarns < ActiveRecord::Migration[6.1]
  def change
    create_table :yarns do |t|
      t.string :brand_name
      t.string :colorway
      t.string :fiber
      t.string :weight
      t.integer :yardage
      t.integer :quantity
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :project, foreign_key: true

      t.timestamps
    end
  end
end
