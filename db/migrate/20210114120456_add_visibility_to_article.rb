class AddVisibilityToArticle < ActiveRecord::Migration[6.0]
  def change
    change_table :articles do |t|
      t.boolean :is_visible
    end
  end
end
