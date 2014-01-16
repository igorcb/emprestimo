class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :nome, limit: 50, null: false
      t.string :cidade, limit: 20, null: false
      t.integer :empresa_id, index: true, null: false
      t.integer :uuid

      t.timestamps
    end
    add_index :clientes, [:empresa_id, :uuid], unique: true
  end
end
