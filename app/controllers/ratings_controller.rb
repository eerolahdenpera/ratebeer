class RatingsController < ApplicationController
  def create
    #byebug
    #raise
    Rating.create params.require(:rating).permit(:score, :beer_id)
    redirect_to ratings_path
  end

  def index
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
  end

end