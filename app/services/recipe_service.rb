class  RecipeService
    def call(ingredient_ids:)
        return Recipe.none if ingredient_ids.empty?
        recipe_ids = RecipeIngredient
        .where(ingredient_id: ingredient_ids)
        .group(:recipe_id)
        .having('COUNT(DISTINCT ingredient_id) = ?', ingredient_ids.size)
        .pluck(:recipe_id)

        Recipe.includes(:ingredients).where(id: recipe_ids)
    end
end