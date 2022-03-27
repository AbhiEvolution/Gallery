# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    redirect_to albums_path if user_signed_in?
    @q = Album.where(published: true).ransack(params[:q])
    @albums = @q.result.includes(:tags)
    @user = User.all
  end

  def search
    index
    render :index
  end

  def show
    @album = Album.find(params[:id])
  end
end
