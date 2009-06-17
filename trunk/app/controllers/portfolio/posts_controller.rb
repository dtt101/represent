class Portfolio::PostsController < ApplicationController

  before_filter :find_portfolio
  before_filter :authorize_as_owner, :only => [:destroy, :edit, :update, :new, :create, :confirm]
  layout 'portfolio'

  # NOTE: haven't figured how to map resources when id isn't in URL
  # So this looks restful - but isn't

  def index
    if @owner
      @posts = @portfolio.posts
    else
      if @portfolio.user.contacts.include?(@user)
        @posts = @portfolio.posts.find(:all, :conditions => ["privacy = ? or privacy = ?", 'public', 'shared'])
      else 
        @posts = @portfolio.posts.find(:all, :conditions => ["privacy = ?", 'public'])
      end
    end
  end

  def show
    id = @portfolio.id
    post_id = params[:post_id]
    post = Post.find(post_id, :conditions => ["portfolio_id = ?", id])
    if @owner
      @post = post
    else 
      if @portfolio.user.contacts.include?(@user) && (post.privacy == ('shared' || 'public'))
        @post = post
      elsif post.privacy == 'public'
        @post = post
      end
    end  
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post])
    @post.portfolio_id = @portfolio.id
    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to(:action => 'index')
    else
      render :action => "new"
    end
  end

  def edit
    id = @portfolio.id
    post_id = params[:post_id]
    @post = Post.find(post_id, :conditions => ["portfolio_id = ?", id])
  end

  def update
    @post = Post.find(params[:post_id]) 
    if @post.update_attributes(params[:post])
      flash[:notice] = 'Post was successfully updated.'
      redirect_to(:action => 'show', :post_id => @post.id)
    else
      render :action => "edit"
    end
  end

  def confirm
    @post = Post.find(params[:post_id])     
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @post.destroy
    redirect_to(:action => 'index')
  end
  
end
