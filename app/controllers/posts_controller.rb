class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :post_users, only: [:index, :show, :new, :edit, :confirm]
  before_action :set_currentuser, only: [:index, :show, :new, :edit, :confirm]
  def index
    @posts = Post.all
    @users = User.all
  end
  def new
    @post = Post.new
  end
  def create
    @post = current_user.posts.build(post_params)
    if params[:back]
      render :new
    else
      if @post.save
        ContactMailer.contact_mail(@post).deliver  ##追記
        redirect_to posts_path, notice: "新たに投稿しました"
      else
        render :new
      end
    end
  end
  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id)
  end
  def edit
    if @post == current_user
      render "edit"
    else
      redirect_to posts_path
    end
  end
  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "投稿を編集しました"
    else
      render :edit
    end
  end
  def destroy
    @post.destroy
    redirect_to posts_path, notice:"投稿を削除しました"
  end
  def confirm
    @post = current_user.posts.build(post_params)
    render :new if @post.invalid?
  end
  private
  def post_params
    params.require(:post).permit(:title, :content, :image, :image_cache)
  end
  def set_post
    @post = Post.find(params[:id])
  end
  def post_users
    @post_users = Post.select(:user_id).distinct
  end
  def set_currentuser
    @current_user = current_user
  end
end
