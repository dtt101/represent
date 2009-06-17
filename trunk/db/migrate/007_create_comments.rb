class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :body
      t.integer :user_id, :null => false
      t.integer :post_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end