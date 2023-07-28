class ReviewsController < ApplicationController

  def new
    # this is only for the form
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new(restaurant: @restaurant)
    authorize @review
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id]) # pulling the id from the url
    @review = Review.new(review_params) # this is only things from the from
    @review.restaurant = @restaurant # adding the belongs_to here
    authorize @review

    if @review.save
      # redirect_to restaurant's page
      redirect_to restaurant_path(@restaurant)
    else
      # display the form again
      render "restaurants/show", status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    authorize @review
    @review.destroy
    redirect_to restaurant_path(@review.restaurant), status: :see_other
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
