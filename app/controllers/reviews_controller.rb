class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    # we need @restaurant in our `simple_form_for`
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.restaurant = Restaurant.find(params[:restaurant_id])
    @review.save
    if @review.save == true
      redirect_to restaurant_path(@review.restaurant)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @review = Review.find(params[:id])
    @review.update(review_params)

    redirect_to reviews_path
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    redirect_to reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
