class RemovePublicColumnFromPosts < ActiveRecord::Migration
  def self.up
    remove_column :posts, :public
  end

  def self.down
    add_column :posts, :public, :boolean
  end
end
