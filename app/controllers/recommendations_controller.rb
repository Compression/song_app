class RecommendationsController < ApplicationController

  def index

  end

  def create
    @recommendation = Api.recommend(params[:name])
    @describe = Api.describe(params[:genre])

    render "show"
  end

  def new

  end

  def show
     @recommendation
     @describe
  end
end
