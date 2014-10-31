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

  def destroy
    @note = Note.find(params[:id])
    track = @note.track_id
    if current_user.id == @note.user_id
      @note.delete
      redirect_to track_url(track)
    else
      render text: "YOU CAN'T DO THAT!!", status: 403
    end

  end



private
  def note_params
    params.require(:note).permit(:track_id, :track_note)
  end
end
