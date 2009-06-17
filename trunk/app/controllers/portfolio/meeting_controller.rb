class Portfolio::MeetingController < ApplicationController
  before_filter :find_portfolio
  before_filter :authorize_as_owner, :only => [:edit, :new, :create, :update, :confirm, :destroy]
  layout 'portfolio'  
  
  def index
    if @owner
      @meetings = @portfolio.meetings
    else
      if @portfolio.user.contacts.include?(@user)
        @meetings = @portfolio.meetings.find(:all, :conditions => ["privacy = ? or privacy = ?", 'public', 'shared'])
      else 
        @meetings = @portfolio.meetings.find(:all, :conditions => ["privacy = ?", 'public'])
      end
    end    
  end
  
  def new
    @meeting = Meeting.new
  end
  
  def create
    @meeting = Meeting.new(params[:meeting])
    @meeting.portfolio_id = @portfolio.id
    if @meeting.save
      flash[:notice] = 'The meeting was successfully created.'
      redirect_to(:action => 'index')
    else
      render :action => "new"
    end
  end
  
  def show
    id = @portfolio.id
    meeting_id = params[:meeting_id]
    meeting = Meeting.find(meeting_id, :conditions => ["portfolio_id = ?", id])
    if @owner
      @meeting = meeting
    else 
      if @portfolio.user.contacts.include?(@user) && (meeting.privacy == ('shared' || 'public'))
        @meeting = meeting
      elsif meeting.privacy == 'public'
        @meeting = meeting
      end
    end
  end

  def edit
    id = @portfolio.id
    meeting_id = params[:meeting_id]
    @meeting = Meeting.find(meeting_id, :conditions => ["portfolio_id = ?", id])
  end
  
  def update
    @meeting = Meeting.find(params[:meeting_id]) 
    if @meeting.update_attributes(params[:meeting])
      flash[:notice] = 'Your meeting was successfully updated.'
      redirect_to(:action => 'show', :meeting_id => @meeting.id)
    else
      render :action => "edit"
    end
  end  

  def confirm
    @meeting = Meeting.find(params[:meeting_id])     
  end
  
  def destroy
    @meeting = Meeting.find(params[:meeting_id])
    @meeting.destroy
    redirect_to(:action => 'index')
  end
  
end
