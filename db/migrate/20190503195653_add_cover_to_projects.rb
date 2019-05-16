class AddCoverToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :cover, :string
  end
end
