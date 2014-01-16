class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login, limit: 30
      t.references :empresa, index: true
      t.references :cidade, index: true

      t.timestamps
    end
    add_index :users, :login, unique: true
  end
end
