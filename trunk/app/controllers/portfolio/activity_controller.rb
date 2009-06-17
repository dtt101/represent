class Portfolio::ActivityController < ApplicationController
  
  before_filter :find_portfolio
  before_filter :authorize_as_owner, :only => [:edit, :new, :create, :update, :confirm, :destroy]
  layout 'portfolio'
  
  def index
    if @owner
      @activities = @portfolio.activities
    else
      if @portfolio.user.contacts.include?(@user)
        @activities = @portfolio.activities.find(:all, :conditions => ["privacy = ? or privacy = ?", 'public', 'shared'])
      else 
        @activities = @portfolio.activities.find(:all, :conditions => ["privacy = ?", 'public'])
      end
    end
  end
  
  def new
    @activity = Activity.new
  end
  
  def create
    @activity = Activity.new(params[:activity])
    @activity.portfolio_id = @portfolio.id
    if @activity.save
      flash[:notice] = 'The activity was successfully created.'
      redirect_to(:action => 'index')
    else
      render :action => "new"
    end
  end
  
  def show
    id = @portfolio.id
    activity_id = params[:activity_id]
    activity = Activity.find(activity_id, :conditions => ["portfolio_id = ?", id])
    if @owner
      @activity = activity
    else 
      if @portfolio.user.contacts.include?(@user) && (activity.privacy == ('shared' || 'public'))
        @activity = activity
      elsif activity.privacy == 'public'
        @activity = activity
      end
    end
  end
  
  def edit
    id = @portfolio.id
    activity_id = params[:activity_id]
    @activity = Activity.find(activity_id, :conditions => ["portfolio_id = ?", id])
  end
  
  def update
    @activity = Activity.find(params[:activity_id]) 
    if @activity.update_attributes(params[:activity])
      flash[:notice] = 'Your activity was successfully updated.'
      redirect_to(:action => 'show', :activity_id => @activity.id)
    else
      render :action => "edit"
    end
  end
  
  def confirm
    @activity = Activity.find(params[:activity_id])     
  end
  
  def destroy
    @activity = Activity.find(params[:activity_id])
    @activity.destroy
    redirect_to(:action => 'index')
  end
  
end
