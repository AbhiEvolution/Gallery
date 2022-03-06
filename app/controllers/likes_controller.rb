class LikesController < ApplicationController
  before_action :find_album
  before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @album.likes.create(user_id: current_user.id)
    end
    redirect_to all_albums_path(@album)
  end

  def already_liked?
    Like.where(user_id: current_user.id, album_id: params[:album_id]).exists?
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
    redirect_to all_albums_path(@album)
  end

  def find_like
    @like = @album.likes.find(params[:id])
  end

  private

  def find_album
    @album = Album.find(params[:album_id])
  end
end
