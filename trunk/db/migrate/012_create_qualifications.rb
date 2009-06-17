class CreateQualifications < ActiveRecord::Migration
  def self.up
    create_table :qualifications do |t|
      t.string :name
      t.string :type
      t.string :grade
      t.datetime :qualification_date
      t.integer :user_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :qualifications
  end
end
