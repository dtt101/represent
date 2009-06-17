class AddPrivacyColumnToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :privacy, :string
  end

  def self.down
    remove_column :posts, :privacy
  end
end
