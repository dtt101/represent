class Portfolio::ExperienceController < ApplicationController
  
  before_filter :find_portfolio
  before_filter :authorize_as_owner, :only => [:edit, :new, :create, :update, :confirm, :destroy]
  layout 'portfolio'
  
  def index
    if @owner
      @experiences = @portfolio.experiences
    else
      if @portfolio.user.contacts.include?(@user)
        @experiences = @portfolio.experiences.find(:all, :conditions => ["privacy = ? or privacy = ?", 'public', 'shared'])
      else 
        @experiences = @portfolio.experiences.find(:all, :conditions => ["privacy = ?", 'public'])
      end
    end
  end
  
  def new
    @experience = Experience.new
  end
  
  def create
    @experience = Experience.new(params[:experience])
    @experience.portfolio_id = @portfolio.id
    if @experience.save
      flash[:notice] = 'The experience was successfully recorded.'
      redirect_to(:action => 'index')
    else
      render :action => "new"
    end
  end
  
  def show
    id = @portfolio.id
    experience_id = params[:experience_id]
    experience = Experience.find(experience_id, :conditions => ["portfolio_id = ?", id])
    if @owner
      @experience = experience
    else 
      if @portfolio.user.contacts.include?(@user) && (experience.privacy == ('shared' || 'public'))
        @experience = experience
      elsif experience.privacy == 'public'
        @experience = experience
      end
    end  
  end
  
  def edit
    id = @portfolio.id
    experience_id = params[:experience_id]
    @experience = Experience.find(experience_id, :conditions => ["portfolio_id = ?", id])
  end
  
  def update
    @experience = Experience.find(params[:experience_id]) 
    if @experience.update_attributes(params[:experience])
      flash[:notice] = 'Your experience was successfully updated.'
      redirect_to(:action => 'show', :experience_id => @experience.id)
    else
      render :action => "edit"
    end
  end
  
  def confirm
    @experience = Experience.find(params[:experience_id])     
  end
  
  def destroy
    @experience = Experience.find(params[:experience_id])
    @experience.destroy
    redirect_to(:action => 'index')
  end
end
