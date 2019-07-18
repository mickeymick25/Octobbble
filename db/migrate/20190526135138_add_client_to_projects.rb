class AddClientToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :clientname, :string
    add_column :projects, :clientlogo, :string
  end
end
