class UsersController < ApplicationController
  def new
    @user = User.new
    @post_users = Post.select(:user_id).distinct
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end
  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
    @post_users = Post.select(:user_id).distinct
    @currnet_user = current_user
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to edit_user_path(@user.id), notice: "プロフィールを更新しました！"
    else
      render :edit
    end
  end
  private
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation, :image, :image_cache)
  end
end
