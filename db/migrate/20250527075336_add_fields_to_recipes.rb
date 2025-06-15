class AddFieldsToRecipes < ActiveRecord::Migration[8.0]
  def change
    change_table :recipes do |t|
      t.string  :title
      t.integer :cook_time
      t.integer :prep_time
      t.float   :ratings
      t.string  :cuisine
      t.string  :category
      t.string  :author
      t.string  :image
    end
  end
end
