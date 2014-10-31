class PostsController < ApplicationController
  
  def show
    @post = Post.find(params[:id])
    render :show
  end
  
  def edit
    @post = Post.find(params[:id])
    render :edit
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to sub_url(@post.sub)
    else
      flash.now[:notice] = @post.errors.full_messages
      render :new
    end
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to sub_url(@post.sub)
    else
      flash.now[:notice] = @post.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    
    redirect_to sub_url(@post.sub)
  end
  
  private
    def post_params
      params.require(:post).permit(:title, :content, :url, :sub_id)
    end
end
