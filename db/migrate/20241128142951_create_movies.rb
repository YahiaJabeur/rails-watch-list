class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.text :overview, null: false
      t.string :poster_url
      t.float :rating, null: false

      t.timestamps
    end
    add_index :movies, :title, unique: true
    add_index :movies, :overview, unique: true
  end
end