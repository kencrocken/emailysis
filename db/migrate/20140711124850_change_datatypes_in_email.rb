class ChangeDatatypesInEmail < ActiveRecord::Migration

  change_table :emails do |t|
    t.change :subject, :text, :limit => nil
    t.change :from, :text, :limit => nil
    t.change :to, :text, :limit => nil
  end
  
end
