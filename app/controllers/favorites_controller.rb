class FavoritesController < ApplicationController
  before_action :require_user_logged_in

  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.favorite(micropost)
    flash[:success] = 'Micropostをお気に入りに追加しました。'
    redirect_to micropost
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unfavorite(micropost)
    flash[:success] = 'Micropostのお気に入りを解除しました。'
    redirect_to micropost
  end
end
