class Portfolio::CommentsController < ApplicationController

  before_filter :authorize
  layout 'portfolio'

  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      flash[:notice] = 'Thanks for your comment.'
    else
      flash[:notice] = 'Sorry there was a problem adding your comment.'
    end
    redirect_to(:controller => "Portfolio::Posts", :action => 'show', :post_id => params[:post_id], :anchor => "comments")
  end
  
  def destroy
    @comment = Comment.find(params[:comment_id])
    @comment.destroy
    redirect_to(:controller => "Portfolio::Posts", :action => 'show', :post_id => params[:post_id], :anchor => "comments")
  end

end
