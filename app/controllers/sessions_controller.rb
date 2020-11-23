class SessionsController < ApplicationController
  def new
    @post_users = Post.select(:user_id).distinct
    @user_all = User.all
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  def destroy
    session.delete(:user_id)
    redirect_to new_session_path
  end
end
