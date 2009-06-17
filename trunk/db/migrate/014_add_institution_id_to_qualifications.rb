class AddInstitutionIdToQualifications < ActiveRecord::Migration
  def self.up
    add_column :qualifications, :institution_id, :int
  end

  def self.down
    remove_column :qualifications, :institution_id
  end
end
