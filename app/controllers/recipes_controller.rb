class RecipesController < ApplicationController
def index
  ingredient_ids = params[:ingredient_ids]&.map(&:to_i)&.uniq || []

  recipes = if ingredient_ids.length > 0
    Recipe
      .joins(:ingredients)
      .where(ingredients: { id: ingredient_ids })
      .group('recipes.id')
      .having('COUNT(DISTINCT ingredients.id) = ?', ingredient_ids.size)
  else
    Recipe.none
  end

  render json: recipes.to_json(include: :ingredients)
end

end
