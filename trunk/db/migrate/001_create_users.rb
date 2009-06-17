class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :hashed_password
      t.string :salt
      t.string :first_name
      t.string :surname
      t.string :email
      t.text :address
      t.string :phone_number
      t.text :status
      t.string :image_url
      t.boolean :administrator

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
