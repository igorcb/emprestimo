class CreateAdvances < ActiveRecord::Migration
  def change
    create_table :advances do |t|
      t.date :data, null: false
      t.decimal :valor, precision: 9, scale: 2, null: false
      t.decimal :saldo, precision: 9, scale: 2, null: false
      t.integer :parcelas, null: false
      t.integer :empresa_id, index: true, null: false
      t.integer :cliente_id, index: true, null: false
      t.integer :uuid, index: true, null: false

      t.timestamps
    end
    add_index :advances, [:empresa_id, :cliente_id, :uuid], unique: true
  end
end
