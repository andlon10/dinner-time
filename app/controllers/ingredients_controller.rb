class IngredientsController < ApplicationController

  def initialize(ingredient_service: IngredientService.new)
    @ingredient_service = ingredient_service
  end

  def index
    qs = params[:query]
    ingredients = @ingredient_service.call(queryString: qs)
    render json: ingredients
  end
end
