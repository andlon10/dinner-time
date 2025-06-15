class IngredientService

    def call(queryString:)
        return Ingredient.none if queryString.blank?
        Ingredient.where("name ILIKE ?", "%#{queryString.strip}%")
    end

end