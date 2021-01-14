class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :user

      t.string :title
      t.string :short_description
      t.text :long_description
      t.boolean :is_private
      t.string :image

      t.timestamps
    end
  end
end
