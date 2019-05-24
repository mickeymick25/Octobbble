class AddProjectIdToShots < ActiveRecord::Migration[5.1]
  def change
    add_column :shots, :project_id, :integer
  end
end
