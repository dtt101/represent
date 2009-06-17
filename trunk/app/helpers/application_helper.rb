# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def is_authorized_user 
    if session[:user_id]
      true
    else
      false
    end
  end
  
end
