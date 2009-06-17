# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
  before_filter :get_owner, :find_user, :get_contact
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '16969206707f39e725314bd21fb77540'
  
  # authorize as logged in user - else redirects to login
  def authorize
    unless User.find_by_id(session[:user_id])
      flash[:notice] = "Login required"
      redirect_to(:controller => "home", :action => "login")
    end
  end
  
  # authorize as admin - tries to redirect user to portfolio
  def authorize_as_admin
    unless session[:administrator]
      redirect_to(:controller => "portfolio", :action => "default", :id => session[:username])
    end
  end
  
  # checks named user in params[:id] (from url) matches session - if not redirects to portfolio
  def authorize_as_owner
    username = params[:id]
    unless session[:username] == username
      redirect_to(:controller => "portfolio", :action => "default", :id => session[:username])
    end    
  end  
  
  # checks if param[:id] is the logged in user - sets @owner
  def get_owner
    username = params[:id]
    if session[:username] == username
      @owner = true
    else
      @owner = false
    end
  end
  
  # when logged in as a user this test if the portfolio you are looking at has been ADDED BY YOU as a contact
  def get_contact
    @portfolio_is_contact = false
    if session[:user_id]
      username = params[:id]
      if session[:username] != username
        logged_in_user = User.find_by_username(session[:username])
        portfolio_contact = logged_in_user.contacts.find_by_username(username)
        if (portfolio_contact)
          @portfolio_is_contact = true
        end
      end
    end
  end
  
  # finds portfolio for named user in params[:id] (from url) - puts into @portfolio
  def find_portfolio
    username = params[:id]
    user = User.find_by_username(username)
    @portfolio = user.portfolio
  end
  
  # finds currently logged in user from session - sets @user
  def find_user
    @user = User.find_by_id(session[:user_id])
  end
  
end
