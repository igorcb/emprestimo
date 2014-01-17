class CreateItemAdvances < ActiveRecord::Migration
  def change
    create_table :item_advances do |t|
      t.string :parcela, limit: 10, null: false
      t.decimal :valor, precision: 10, scale: 2, null: false
      t.date :data_vencimento, index: true, null: false
      t.string :status, limit: 1, null: false
      t.integer :atraso, null: false
      t.date :data_pagamento, index: true
      t.decimal :valor_pago
      t.integer :advance_id, index: true, null: false
      t.integer :empresa_id, index: true, null: false
      t.integer :uuid, index: true, null: false

      t.timestamps
    end
    add_index :item_advances, [:empresa_id, :uuid], unique: true
    execute <<-SQL
      ALTER TABLE ITEM_ADVANCES ADD CONSTRAINT FK_ITEM_ADVANCES_ADVANCE_ID FOREIGN KEY (ADVANCE_ID) REFERENCES ADVANCES (ID)
    SQL
  end
end
