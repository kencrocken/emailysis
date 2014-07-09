class AddFolderToEmail < ActiveRecord::Migration
  def change
    add_column :emails, :folder, :string
  end
end
