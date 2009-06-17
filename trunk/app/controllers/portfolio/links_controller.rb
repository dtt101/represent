class Portfolio::LinksController < ApplicationController
  
  before_filter :find_portfolio
  before_filter :authorize_as_owner, :only => [:create, :destroy, :update, :edit]
  layout 'portfolio'

  def index
    if @owner
      @links = @portfolio.links
    else
      if @portfolio.user.contacts.include?(@user)
        @links = @portfolio.links.find(:all, :conditions => ["privacy = ? or privacy = ?", 'public', 'shared'])
      else 
        @links = @portfolio.links.find(:all, :conditions => ["privacy = ?", 'public'])
      end
    end    
  end
  
  def create
    link = Link.new(params[:link])
    link.portfolio_id = @portfolio.id
    if link.save
      render :update do |page|
        page.insert_html :top, 'links', :partial => 'shared/link', :object => link
        page.visual_effect :highlight, 'link_' + link.id.to_s, :duration => 5, :startcolor => '#E6ECFF'
        page.hide 'link_loader'
      end
    else 
      render :update do |page|
        # TODO - show error message
        page.hide 'link_loader'      
      end       
    end 
  end
  
  # renders edit form
  def edit
    link_id = params[:link_id]
    link = Link.find(link_id)
    render :update do |page|
      page.insert_html :after, 'link_' + link.id.to_s, :partial => 'shared/edit_link', :locals => { :link => link }
      # hide exisiting link list item
      page.hide 'link_' + link.id.to_s
    end
  end
  
  # updates element
  def update
    link_id= params[:link_id]    
    link = Link.find(link_id)
    if link.update_attributes(params[:link])
      render :update do |page|
        page.replace 'link_' + link.id.to_s, :partial => 'shared/link', :object => link
        page.visual_effect :highlight, 'link_' + link.id.to_s, :duration => 5, :startcolor => '#E6ECFF'
        page.hide 'link_edit_loader_' + link.id.to_s
        page.remove 'edit_l_form_' + link.id.to_s
      end
    else 
      render :update do |page|
        # TODO show title required message
        page.hide 'link_edit_loader_' + link.id.to_s
      end
    end    
  end  
  
  def destroy
    link_id = params[:link_id]
    link = Link.find(link_id)
    if link.destroy
      render :update do |page|
        page.remove 'link_' + link.id.to_s
      end
    end
  end
  
end
