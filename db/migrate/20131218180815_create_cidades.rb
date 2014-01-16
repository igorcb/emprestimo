class CreateCidades < ActiveRecord::Migration
  def change
    create_table :cidades do |t|
      t.string :nome, limit: 50, null: false
      t.integer :sabado

      t.timestamps
    end
    add_index :cidades, :nome, unique: true
  end
end
