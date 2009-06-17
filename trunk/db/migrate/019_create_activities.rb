class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :description
      t.string :location
      t.datetime :start_date
      t.datetime :end_date
      t.text :result
      t.string :privacy
      t.integer :portfolio_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
