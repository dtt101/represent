class Post < ActiveRecord::Base
  belongs_to :portfolio
  has_many :comments, :order => 'created_at ASC', :dependent => :destroy
  named_scope :recent, lambda { { :conditions => ['created_at > ? or updated_at > ?', 1.week.ago, 1.week.ago] } }
  
  validates_presence_of :title, :portfolio_id
  validates_inclusion_of :privacy,
                         :in => %w{ private shared public },
                         :message => "is not a valid privacy setting."

end
