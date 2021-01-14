class AddReferenceToArticles < ActiveRecord::Migration[6.0]
  def change
    change_table :articles do |t|
      t.string :reference, unique: true
    end
  end
end
