class CreateIndexUsers < ActiveRecord::Migration
  def change
    create_table :index_users do |t|

      t.timestamps null: false
    end
  end
end
