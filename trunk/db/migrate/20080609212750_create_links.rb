class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :name
      t.string :url
      t.text :description
      t.string :privacy
      t.integer :portfolio_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
