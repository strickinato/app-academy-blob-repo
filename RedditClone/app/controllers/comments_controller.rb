class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    render :new
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash.now[:notice] = @comment.errors.full_messages
      render :new
    end
    
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
