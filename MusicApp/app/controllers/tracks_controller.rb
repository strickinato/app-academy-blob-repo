class TracksController < ApplicationController
  before_action :require_login
  
  def new
    @track = Track.new
    render :new

  end

  def create
    @track = Track.new(track_params)

    if @track.save
      render :show
    else
      flash[:notice] = @track.errors.full_messages
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def edit
    @track = Track.find(params[:id])
    render :update
  end



private
  def track_params
    params.require(:track).permit(:title)
  end
end
