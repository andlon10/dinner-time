require 'json'

puts "Fetching file"
file_path = Rails.root.join('db', 'recipes-en.json')
recipes_data = JSON.parse(File.read(file_path))

puts "Clearing old data"
RecipeIngredient.delete_all
Ingredient.delete_all
Recipe.delete_all

puts "Seeding"
ingredient_cache = {}

recipes_data.each_with_index do |data, index|
  recipe = Recipe.create!(
    title:       data["title"],
    cook_time:   data["cook_time"],
    prep_time:   data["prep_time"],
    ratings:     data["ratings"],
    cuisine:     data["cuisine"],
    category:    data["category"],
    author:      data["author"],
    image:       data["image"]
  )

  data["ingredients"].each do |full_ingredient|

    cleaned = full_ingredient.gsub(/^\d+.*?(cup|tsp|tbsp|ounce|ml|g|kg)?\s*/i, "").strip.downcase

    ingredient = ingredient_cache[cleaned] ||= Ingredient.find_or_create_by!(name: cleaned)

    RecipeIngredient.create!(
      recipe: recipe,
      ingredient: ingredient
    )
  end

end

puts "Finished seeding #{recipes_data.size} recipes"
puts "Ingredients count: #{Ingredient.count}"
