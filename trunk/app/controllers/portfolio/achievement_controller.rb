class Portfolio::AchievementController < ApplicationController
  before_filter :find_portfolio
  before_filter :authorize_as_owner, :only => [:edit, :new, :create, :update, :confirm, :destroy]
  layout 'portfolio'
  
  def index
    if @owner
      @achievements = @portfolio.achievements
    else
      if @portfolio.user.contacts.include?(@user)
        @achievements = @portfolio.achievements.find(:all, :conditions => ["privacy = ? or privacy = ?", 'public', 'shared'])
      else 
        @achievements = @portfolio.achievements.find(:all, :conditions => ["privacy = ?", 'public'])
      end
    end    
  end


 def new
   @achievement = Achievement.new
 end
 
 def create
   @achievement = Achievement.new(params[:achievement])
   @achievement.portfolio_id = @portfolio.id
   if @achievement.save
     flash[:notice] = 'Your achievement was successfully created.'
     redirect_to(:action => 'index')
   else
     render :action => "new"
   end
 end
 
 def show
   id = @portfolio.id
   achievement_id = params[:achievement_id]
   achievement = Achievement.find(achievement_id, :conditions => ["portfolio_id = ?", id])
   if @owner
     @achievement = achievement
   else 
     if @portfolio.user.contacts.include?(@user) && (achievement.privacy == ('shared' || 'public'))
       @achievement = achievement
     elsif achievement.privacy == 'public'
       @achievement = achievement
     end
   end
 end

 def edit
   id = @portfolio.id
   achievement_id = params[:achievement_id]
   @achievement = Achievement.find(achievement_id, :conditions => ["portfolio_id = ?", id])
 end
 
 def update
   @achievement = Achievement.find(params[:achievement_id]) 
   if @achievement.update_attributes(params[:achievement])
     flash[:notice] = 'Your achievement was successfully updated.'
     redirect_to(:action => 'show', :achievement_id => @achievement.id)
   else
     render :action => "edit"
   end
 end  

 def confirm
   @achievement = Achievement.find(params[:achievement_id])     
 end
 
 def destroy
   @achievement = Achievement.find(params[:achievement_id])
   @achievement.destroy
   redirect_to(:action => 'index')
 end  
end
