class ChangeStatusTypeToString < ActiveRecord::Migration
  def self.up
    change_column :users, :status, :string
  end

  def self.down
    change_column :users, :status, :text
  end
end
