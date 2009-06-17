class RenameUserIdToPortfolioId < ActiveRecord::Migration
  def self.up
    rename_column :institutions, :user_id, :portfolio_id
    rename_column :qualifications, :user_id, :portfolio_id
  end

  def self.down
    rename_column :institutions, :portfolio_id, :user_id
    rename_column :qualifications, :portfolio_id, :user_id
  end
end
