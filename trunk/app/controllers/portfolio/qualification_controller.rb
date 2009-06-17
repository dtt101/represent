class Portfolio::QualificationController < ApplicationController
  
  before_filter :authorize_as_owner
  before_filter :find_portfolio
    
  def create
    qualification = Qualification.new(params[:qualification])
    qualification.portfolio_id = @portfolio.id
    if qualification.save
      render :update do |page|
        page.insert_html :bottom, 'qualifications_at_' + qualification.institution.id.to_s, :partial => 'shared/qualification', :object => qualification
        page.visual_effect :highlight, 'qualification_' + qualification.id.to_s, :duration => 5, :startcolor => '#E6ECFF'
        page.hide 'qualification_loader_' + qualification.institution.id.to_s
      end
    else 
      render :update do |page|
        # TODO - show error message
        page.hide 'qualification_loader_' + qualification.institution.id.to_s        
      end       
    end    
  end
  
  # renders edit form
  def edit
    qualification_id = params[:qualification_id]
    qualification = Qualification.find(qualification_id)
    render :update do |page|
      page.insert_html :after, 'qualification_' + qualification.id.to_s, :partial => 'shared/edit_qualification', :locals => { :qualification => qualification }
      # hide exisiting qualification list item
      page.hide 'qualification_' + qualification.id.to_s
    end
  end
  
  # updates element
  def update
    qualification_id = params[:qualification_id]    
    qualification = Qualification.find(qualification_id)
    if qualification.update_attributes(params[:qualification])
      render :update do |page|
        page.replace 'qualification_' + qualification.id.to_s, :partial => 'shared/qualification', :object => qualification
        page.visual_effect :highlight, 'qualification_' + qualification.id.to_s, :duration => 5, :startcolor => '#E6ECFF'
        page.hide 'qualification_edit_loader_' + qualification.id.to_s
        page.remove 'edit_q_form_' + qualification.id.to_s
      end
    else 
      render :update do |page|
        # TODO show title required message
        page.hide 'qualification_edit_loader_' + qualification.id.to_s
      end
    end    
  end
  
  def destroy
    qualification_id = params[:qualification_id]
    qualification = Qualification.find(qualification_id)
    if qualification.destroy
      render :update do |page|
        page.remove 'qualification_' + qualification.id.to_s
      end
    end
  end
  
end
