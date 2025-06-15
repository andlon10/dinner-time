class RecipesController < ApplicationController

    def initialize(recipe_service: RecipeService.new)
        @recipe_service = recipe_service
    end

    def index
        ingredient_ids = params[:ingredient_ids]&.map(&:to_i)&.uniq || []
        recipes = @recipe_service.call(ingredient_ids: ingredient_ids)
        render json: recipes.to_json(include: :ingredients)
    end
end
