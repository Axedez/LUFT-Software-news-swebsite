class UpdateUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.string :username
      t.integer :role, default: 0
    end
  end
end
