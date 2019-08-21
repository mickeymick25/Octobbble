class AddMediaUrlAndExpiryToShots < ActiveRecord::Migration[5.1]
  def change
    add_column :shots, :media_url, :string
    add_column :shots, :media_url_expiry, :timestamp
  end
end
