class ShotsTableRenameUserShotToS3Key < ActiveRecord::Migration[5.1]
  def change
    rename_column :shots, :user_shot, :s3_key
  end
end
