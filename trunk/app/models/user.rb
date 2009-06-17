require 'digest/sha1'

class User < ActiveRecord::Base
  has_one :portfolio
  has_many :comments
  has_and_belongs_to_many :contacts, 
    :class_name => "User",
    :join_table => "contacts_users", 
    :association_foreign_key => "contact_id", 
    :foreign_key => "user_id"
  
  validates_presence_of :username, :email, :first_name, :surname
  validates_uniqueness_of :username
  validates_presence_of :password, :on => :create
  
  attr_accessor :password_confirmation
  validates_confirmation_of :password
  
  def self.authenticate(username, password)
    user = self.find_by_username(username)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end
  
  def validate
    errors.add_to_base("Missing password") if hashed_password.blank?
  end
  
  # password is a virtual attribute
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  
  def after_destroy
    if User.count.zero?
      raise "Can't delete last user"
    end
  end
  
  def full_name
    self.first_name + " " + self.surname
  end
  
  def find_contactees
    @contactees = User.find_by_sql ["SELECT users.id, users.first_name, users.surname, users.username FROM users INNER JOIN contacts_users ON users.id = contacts_users.user_id WHERE contacts_users.contact_id = ?", self.id]
  end
  
  private
  
  def self.encrypted_password(password, salt)
    string_to_hash = password + "montgomery" + salt # 'montgomery' makes it harder to guess
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
end