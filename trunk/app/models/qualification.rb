class Qualification < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :institution
  named_scope :recent, lambda { { :conditions => ['created_at > ? or updated_at > ?', 1.week.ago, 1.week.ago] } }
  validates_presence_of :description, :portfolio_id, :qualification_date, :institution_id, :name
end
