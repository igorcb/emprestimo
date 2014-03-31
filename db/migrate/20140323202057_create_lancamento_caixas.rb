class CreateLancamentoCaixas < ActiveRecord::Migration
  def change
    create_table :lancamento_caixas do |t|
      t.integer :caixa_id, null: false
      t.date :data, null: false
      t.decimal :credito, precision: 9, scale: 2, null: false
      t.decimal :debito, precision: 9, scale: 2, null: false
      t.string :descricao, null: false
      t.integer :empresa_id, null: false
      t.integer :uuid, index: true, null: false

      t.timestamps
    end
    add_index :lancamento_caixas, [:empresa_id, :uuid], unique: true
    execute <<-SQL
      ALTER TABLE LANCAMENTO_CAIXAS ADD CONSTRAINT FK_LANCAMENTO_CAIXA_CAIXA_ID FOREIGN KEY (CAIXA_ID) REFERENCES CAIXAS (ID)
    SQL
  end
end
