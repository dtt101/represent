class CreateExperiences < ActiveRecord::Migration
  def self.up
    create_table :experiences do |t|
      t.string :employer
      t.string :role
      t.string :location
      t.datetime :start_date
      t.datetime :end_date
      t.text :notes
      t.string :privacy
      t.integer :portfolio_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :experiences
  end
end
