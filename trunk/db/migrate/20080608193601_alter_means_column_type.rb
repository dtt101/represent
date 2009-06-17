class AlterMeansColumnType < ActiveRecord::Migration
  def self.up
    change_column :achievements, :means, :text 
  end

  def self.down
    change_column :achievements, :means, :string 
  end
end
