class AddMediaTypeToShots < ActiveRecord::Migration[5.1]
  def change
    add_column :shots, :mime_type, :string
  end
end
