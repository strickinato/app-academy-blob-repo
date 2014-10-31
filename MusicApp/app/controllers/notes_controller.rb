class NotesController < ApplicationController
  before_action :require_login

  # def new
  #   @track = Track.new
  #   render :new
  # end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    if @note.save
      redirect_to track_url(@note.track_id)
    else
      flash.now[:notice] = @note.errors.full_messages
      redirect_to track_url(@note.track_id)
    end
  end
  #
  # def show
  #   @track = Track.find(params[:id])
  #   render :show
  # end
  #
  # def edit
  #   @track = Track.find(params[:id])
  #   render :update
  # end



private
  def note_params
    params.require(:note).permit(:track_id, :note)
  end
end
