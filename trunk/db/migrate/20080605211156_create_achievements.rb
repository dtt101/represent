class CreateAchievements < ActiveRecord::Migration
  def self.up
    create_table :achievements do |t|
      t.string :location
      t.datetime :achievement_date
      t.text :description
      t.string :means
      t.string :privacy
      t.integer :portfolio_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :achievements
  end
end
