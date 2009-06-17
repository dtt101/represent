class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  named_scope :recent, lambda { { :conditions => ['created_at > ? or updated_at > ?', 1.week.ago, 1.week.ago] } }
    
  validates_presence_of :body, :post_id, :user_id

end
