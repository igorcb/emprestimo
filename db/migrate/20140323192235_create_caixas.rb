class CreateCaixas < ActiveRecord::Migration
  def change
    create_table :caixas do |t|
      t.string :descricao, limit: 50, null: false
      t.date :data_abertura, null: false
      t.time :hora_abertura, null: false
      t.date :data_fechamento
      t.string :hora_fechamento
      t.time :hora_fechamento
      t.decimal :valor, precision: 9, scale: 2, null: false
      t.integer :status, null: false
      t.integer :empresa_id, null: false
      t.integer :uuid, index: true, null: false

      t.timestamps
    end
    add_index :caixas, [:empresa_id, :uuid], unique: true
  end
end
