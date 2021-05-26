class RemoveForeignKeyFromYarn < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :yarns, :projects
  end
end
