class CreateMeetings < ActiveRecord::Migration
  def self.up
    create_table :meetings do |t|
      t.string :attendees
      t.string :location
      t.datetime :when
      t.text :result
      t.string :privacy
      t.integer :portfolio_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :meetings
  end
end