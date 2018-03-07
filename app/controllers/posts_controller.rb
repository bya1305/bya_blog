class PostsController < ApplicationController
  def index
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


  private

    def post_params
      params.require(:post).permit(:title, :body)
    end
end
