class IngredientsController < ApplicationController
  def index
    queryString = params[:query].to_s.strip

    if queryString.present?
      ingredients = Ingredient.where("name ILIKE ?", "%#{queryString}%")
    else
      ingredients = []
    end

    render json: ingredients
  end
end
