class CatRentalRequestsController < ApplicationController
  before_action :ensure_user_authorized, only: [:approve, :deny]
  def new
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new
    render :new
  end
  
  def create
    @cat_rental_request = CatRentalRequest.new(request_params)
    @cat_rental_request.user_id = current_user.id
    
    if @cat_rental_request.save
      flash[:notice] = "A new rental request for #{@cat_rental_request.cat.name} has been made"
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      render :new
    end
  end
  
  def approve
    @cat_rental_request = CatRentalRequest.find(params[:cat_rental_request_id])
    @cat_rental_request.approve!
    redirect_to cat_url(@cat_rental_request.cat_id)
  end
  
  def deny
    @cat_rental_request = CatRentalRequest.find(params[:cat_rental_request_id])
    @cat_rental_request.deny!
    redirect_to cat_url(@cat_rental_request.cat_id)
  end
  
  private
  def request_params
    params
      .require(:cat_rental_request)
      .permit(:cat_id, :start_date, :end_date, :user_id)
  end
  
  def ensure_user_authorized
    @cat_rental_request = CatRentalRequest.find(params[:cat_rental_request_id])
    unless @cat_rental_request.cat.user_id == current_user.id
      flash[:notice] = "You are not authorized to approve or deny. Go approve your own cat rental!"
      redirect_to cat_url(@cat_rental_request.cat)
    end
  end
end
