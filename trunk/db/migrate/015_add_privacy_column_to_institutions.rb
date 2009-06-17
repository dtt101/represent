class AddPrivacyColumnToInstitutions < ActiveRecord::Migration
  def self.up
    add_column :institutions, :privacy, :string
  end

  def self.down
    remove_column :institutions, :privacy
  end
end
