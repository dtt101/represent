class CreatePortfolios < ActiveRecord::Migration
  def self.up
    create_table :portfolios do |t|
      t.string :title
      t.integer :user_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :portfolios
  end
end
