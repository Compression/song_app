class RecommendationsController < ApplicationController

  def index
    @search = Cat.search_name(params[:name]).page(params[:page]).per(CATS_PER_PAGE)

    if @search.empty?
      @search = Cat.search_description(params[:name]).page(params[:page]).per(CATS_PER_PAGE)
    end
  end

  def create
    @recommendation = Api.recommend(params[:name])

    render "show"
  end

  def new

  end

  def show
    # @recommendation
  end
end
