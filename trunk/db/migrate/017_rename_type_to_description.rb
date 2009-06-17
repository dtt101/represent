class RenameTypeToDescription < ActiveRecord::Migration
  def self.up
    rename_column :qualifications, :type, :description
  end

  def self.down
    rename_column :qualifications, :description, :type
  end
end
