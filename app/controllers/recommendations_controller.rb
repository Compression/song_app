class RecommendationsController < ApplicationController

  def index

  end

  def create

    @recommendation = Api.recommend(params[:name])

    render "show"
  end

  def new

  end

  def show
     @describe = genre_descriptions
  end
end
