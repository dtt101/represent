class Portfolio::EducationController < ApplicationController
  
  before_filter :find_portfolio
  before_filter :authorize_as_owner, :only => [:edit, :new, :create, :update, :confirm, :destroy]
  layout 'portfolio'

  def index
    if @owner
      @institutions = @portfolio.institutions
      @qualification = Qualification.new
    else
      if @portfolio.user.contacts.include?(@user)
        @institutions = @portfolio.institutions.find(:all, :conditions => ["privacy = ? or privacy = ?", 'public', 'shared'])
      else 
        @institutions = @portfolio.institutions.find(:all, :conditions => ["privacy = ?", 'public'])
      end
    end
  end
  
  def new
    @institution = Institution.new
  end
  
  def create
    @institution = Institution.new(params[:institution])
    @institution.portfolio_id = @portfolio.id
    if @institution.save
      flash[:notice] = 'The institution was successfully created.'
      redirect_to(:action => 'index')
    else
      render :action => "new"
    end
  end
  
  def edit
    id = @portfolio.id
    institution_id = params[:institution_id]
    @institution = Institution.find(institution_id, :conditions => ["portfolio_id = ?", id])
  end

  def update
    id = params[:institution_id]
    @institution = Institution.find(id) 
    if @institution.update_attributes(params[:institution])
      flash[:notice] = 'The institution was successfully updated.'
      redirect_to(:action => 'index')
    else
      render :action => "edit"
    end
  end

  def confirm
    id = params[:institution_id]
    @institution = Institution.find(id)     
  end
  
  def destroy
    id = params[:institution_id]
    @institution = Institution.find(id)
    @institution.destroy
    redirect_to(:action => 'index')
  end
end
