class HomeController < ApplicationController
  
  def index
    
  end
  
  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        session[:username] = user.username # for convenience - saves multiple db lookups
        session[:administrator] = user.administrator
        redirect_to(:controller => "portfolio", :action => "default", :id => user.username)
      else
        flash[:notice] = "Invalid username/password combination"
      end
    end
  end

  def logout
    reset_session
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end

  def forgotten_password
    # TODO
  end
  
  def about
  end
end
