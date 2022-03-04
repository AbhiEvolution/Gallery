class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to albums_path
    end
    @q = Album.where(published: true).ransack(params[:q])
    @albums = @q.result.includes(:tags)
    @user=User.all
  end

  def search
    index
    render :index
  end

  def show
    @album = Album.find(params[:id])
  end
end
