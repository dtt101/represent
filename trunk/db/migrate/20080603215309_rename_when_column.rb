class RenameWhenColumn < ActiveRecord::Migration
  def self.up
    rename_column :meetings, :when, :meeting_date
  end

  def self.down
    rename_column :meetings, :meeting_date, :when
  end
end
