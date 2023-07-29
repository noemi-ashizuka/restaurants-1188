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
        respond_to do |format|
          format.html { redirect_to restaurant_path(@restaurant) }
          format.json do
            # send the json with the new review and the empty form
            render json: {
              review_html: render_to_string(partial: "reviews/review", formats: :html, locals: { review: @review }),
              form_html: render_to_string(partial: "reviews/new", formats: :html, locals: { restaurant: @review.restaurant, review: Review.new })
          }.to_json
          end
        end
      else
        # display the form again
        respond_to do |format|
          format.html { render "restaurants/show", status: :unprocessable_entity }
          format.json do
            render json: {
              form_html: render_to_string(partial: "reviews/new", formats: :html, locals: { restaurant: @review.restaurant, review: @review })
          }.to_json
          end
        end
        
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
