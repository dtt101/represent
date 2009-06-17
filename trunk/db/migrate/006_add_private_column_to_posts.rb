class AddPrivateColumnToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :public, :boolean 
  end

  def self.down
    remove_column :posts, :public
  end
end
