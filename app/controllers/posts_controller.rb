class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to posts_path
      flash[:notice] = "New Post Created Successfully!"
    else
      flash[:danger] = "Post was not created"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post has been updated!"
      redirect_to @post
    else
      flash.now[:danger] = "Post was not updated =("
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "Post has been deleted!"
      redirect_to posts_path
    end
  end

  protected

    def resource_not_found
      message = "The post you are looking for could not be found"
      flash[:alert] = message
      redirect_to root_path
    end


  private

    def post_params
      params.require(:post).permit(:title, :body)
    end

    def set_post
      @post = Post.find(params[:id])
    end
end
