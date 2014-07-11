class ChangeContentFormatInEmail < ActiveRecord::Migration
  def change
  end

  def up
    add_column :emails, :content, :text, :limit => nil
  end

  def down
    remove_column :emails, :content, :text
  end

end
