class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :pattern_name
      t.string :designer
      t.string :craft
      t.string :tool_size
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
