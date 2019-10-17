class AddOctopodIdToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :octopod_id, :string
  end
end
