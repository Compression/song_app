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
     @recommendation
     @describe
  end
end
