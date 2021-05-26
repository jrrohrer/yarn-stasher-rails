class ChangeColumnProjectId < ActiveRecord::Migration[6.1]
  def change
    change_column :yarns, :project_id, :integer
  end
end
