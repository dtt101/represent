class Portfolio::ContactsController < ApplicationController

  before_filter :authorize_as_owner
  before_filter :find_portfolio
  layout 'portfolio', :except => [:remove, :add]

  def index
    @contacts = @user.contacts
    #@contactees = User.find_by_sql ["SELECT users.id, users.first_name, users.surname, users.username FROM users INNER JOIN contacts_users ON users.id = contacts_users.user_id WHERE contacts_users.contact_id = ?", @user.id]
    @contactees = @user.find_contactees
  end

  def add
    contact_id = params[:contact_id]
    contact = User.find(contact_id)
    @user.contacts << contact
    render :update do |page|
      page.replace_html 'contact', :partial => 'shared/contact', :locals => { :logged_in_user => @user, :contact_user => contact, :is_contact => true }
    end
    
  end

  def remove
    contact_id = params[:contact_id]
    contact = User.find(contact_id)
    @user.contacts.delete(contact)
    render :update do |page|
      page.replace_html "contact", :partial => "shared/contact", :locals => { :logged_in_user => @user, :contact_user => contact, :is_contact => false }
    end
  end
  
end
