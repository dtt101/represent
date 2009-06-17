class CreateInstitutions < ActiveRecord::Migration
  def self.up
    create_table :institutions do |t|
      t.string :name
      t.string :location
      t.datetime :start_date
      t.datetime :end_date
      t.integer :user_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :institutions
  end
end
