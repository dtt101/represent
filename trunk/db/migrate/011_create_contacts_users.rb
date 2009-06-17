class CreateContactsUsers < ActiveRecord::Migration
  def self.up
    create_table :contacts_users, :id=>false do |t|
      t.integer :user_id
      t.integer :contact_id
    end
  end

  def self.down
    drop_table :contacts_users
  end
end
