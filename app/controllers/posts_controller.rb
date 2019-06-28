class PostsController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def create
    @post = Post.create(permitted_post_params.to_hash.merge(user_id: current_user.id))
    if @post
      if @post.persisted?
        redirect_to posts_path, notice: "Post titled '#{@post.title}' created successfully"
      else
        flash.now[:alert] = "Please correct errors below and re-try.\n #{@post.errors.full_messages}"
        render 'new'
      end
    else
      redirect_to posts_path, alert: 'Unable to create this post'
    end
  end

  def destroy
    post = Post.find_by(id: params[:id])

    if post
      post.destroy
      redirect_to posts_path, notice: "Post titled '#{post.title}' has been deleted"
    else
      redirect_to posts_path, notice: "Post with id=#{params[:id]} was deleted earlier"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new(user: current_user)
  end

  def permitted_post_params
    params.require(:post).permit(:title, :category, :body)
  end
end
