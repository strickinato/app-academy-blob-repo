class AlbumsController < ApplicationController

  before_action :require_login

  def new
    @album = Album.new
    render :new

  end

  def create
    @album = Album.new(album_params)

    if @album.save
      render :show
    else
      flash[:notice] = @album.errors.full_messages
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def edit
    @album = Album.find(params[:id])
    render :update
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      render :show
    else
      flash[:notice] = @album.errors.full_messages
      render :edit
    end
  end

private
  def album_params
    params.require(:album).permit(:title, :band_id, :recording_type)
  end
end
