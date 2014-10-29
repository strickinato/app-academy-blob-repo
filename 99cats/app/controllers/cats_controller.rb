class CatsController < ApplicationController
  before_action :user_authorized?, only: [:update, :edit]
  
  def index
    @cats = Cat.all
    render :index
  end
  
  def show
    @cat = Cat.find(params[:id])
    render :show
  end
  
  def new
    @cat = Cat.new
    render :new
  end
  
  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      render :show
    else
      render :new
    end
  end
  
  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end
  
  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end
  
  def approve
    render :show
  end
  
  private
  def cat_params
    params.require(:cat).permit(:name, :birth_date, :sex, :color, :description, :user_id)
  end
  
  def user_authorized?
    @cat = Cat.find(params[:id])
    unless current_user.id == @cat.user_id
      flash[:notice] = "You are not authorized to touch that cat you perv."
      redirect_to cat_url(@cat) 
    end
      
  end
  
end
