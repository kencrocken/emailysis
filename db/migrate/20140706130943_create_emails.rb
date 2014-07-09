class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.belongs_to :project, index: true
      t.string :from
      t.string :to
      t.text :sent_at
      t.string :subject
      t.text :content

      t.timestamps
    end
  end
end
