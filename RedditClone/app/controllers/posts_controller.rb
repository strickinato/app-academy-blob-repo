class PostsController < ApplicationController
  
  def show
    @post = Post.find(params[:id])
    render :show
  end
  
  def edit
    @sub = Sub.find(params[:sub_id])
    @post = Post.find(params[:id])
    render :edit
  end
  
  def new
    @post = Post.new
    # render :new
  end
  
  def create
    @post = Post.new(post_params)
    # @postsub = Postsub.new(post_id: @post.id, sub_id: params[:id])
    
    @post.author_id = current_user.id
    if @post.save
      Postsub.add_subs_from_new_posts(params[:post][:subs], @post.id)
      redirect_to(:back)
    else
      flash.now[:notice] = @post.errors.full_messages
      render :new
    end
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to sub_url(params[:sub_id])
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
      params.require(:post).permit(:title, :content, :url)
    end
end
