class PortfolioController < ApplicationController
  
  protect_from_forgery :except => [:update_user_status]
  
  def default    
    username = params[:id]
    user = User.find_by_username(username)
    if (user)
      if (user.portfolio)
        @portfolio = user.portfolio
        
        # find recent things - sort by most recent date - and filter by status
        recently_active = @portfolio.posts.recent + @portfolio.achievements.recent + @portfolio.activities.recent + @portfolio.institutions.recent + @portfolio.experiences.recent + @portfolio.links.recent + @portfolio.meetings.recent
        recently_active = recently_active.sort_by{|item| item.updated_at}.reverse
        if @owner 
          # show all 
          @recently_active = recently_active
        elsif @portfolio.user.contacts.include?(@user)
          # visitor is a contact show shared & public
          @recently_active = recently_active.find_all{|item| item.privacy == 'public' || item.privacy == 'shared' }
        else
          # just show public
          @recently_active = recently_active.find_all{|item| item.privacy == 'public' }
        end
      else
        @portfolio = create_new_portfolio(user)
      end
    else
      redirect_to :action => :notfound  
    end
      
  end
  
  def notfound
    # no portfolio!
    render(:layout => "application")
  end
  
  # updates user status - desiged for ajax call!
  def update_user_status
    if session[:username] == params[:id]
      user = User.find(params[:action_id])
      new_status = params[:value]
      if new_status.length < 60
        user.status = params[:value]
      else
        user.status = "Less than 60 characters is all we have room for!"
      end
      user.save
      user.reload
      render :text => user.status
    end
  end
  
  private 
  
  def create_new_portfolio(user)
    new_portfolio = Portfolio.new
    new_portfolio.title = "Your Portfolio"
    new_portfolio.user_id = user.id
    new_portfolio.save
    new_portfolio
  end

end
