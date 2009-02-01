class PostsController < ApplicationController
  before_filter :required_login

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # POST /posts
  # POST /posts.xml
  def create
    #TODO dar uma olhada nisso aqui depois
#    @post = @current_user.posts.build(params[:post])
    @post = Post.new(params[:post])
    @post.user_id = @current_user.id

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to(user_home_path) }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        @posts = @current_user.posts
        format.html { render :template => "users/home" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
end
