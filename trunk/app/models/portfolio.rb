class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_many :posts, :order => 'created_at DESC', :dependent => :destroy
  has_many :institutions, :order => 'end_date DESC', :dependent => :destroy
  has_many :experiences, :order => 'end_date DESC', :dependent => :destroy
  has_many :activities, :order => 'end_date DESC', :dependent => :destroy
  has_many :meetings, :order => 'meeting_date DESC', :dependent => :destroy
  has_many :achievements, :order => 'achievement_date DESC', :dependent => :destroy
  has_many :links, :order => 'created_at DESC', :dependent => :destroy
  has_many :qualifications, :dependent => :destroy
  
  validates_presence_of :title, :user_id
end
