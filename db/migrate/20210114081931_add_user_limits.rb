class AddUserLimits < ActiveRecord::Migration[6.0]
    def up
      change_table :users do |t|
        t.change :username, :string, limit: 50, null: false
        t.change :email, :string, limit: 254, null: false
      end
    end
    def down
      change_table :users do |t|
        t.change :username, limit: nil, null: true
        t.change :email, limit: nil, null: true
      end
    end
end
