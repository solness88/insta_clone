class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all
    @current_user = current_user
    @post_users = Post.select(:user_id).distinct
  end
  def create
    favorite = current_user.favorites.create(post_id: params[:post_id])
    redirect_to posts_url, notice: "#{favorite.post.user.name}さんのブログをお気に入り登録しました"
  end
  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to posts_url, notice: "#{favorite.post.user.name}さんのブログをお気に入り解除しました"
  end
end
