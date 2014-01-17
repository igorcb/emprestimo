class CreateAdvances < ActiveRecord::Migration
  def change
    create_table :advances do |t|
      t.date :data, null: false
      t.decimal :valor, precision: 9, scale: 2, null: false
      t.decimal :saldo, precision: 9, scale: 2, null: false
      t.integer :parcelas, null: false
      t.references :empresa, index: true, null: false
      t.references :cliente, index: true, null: false
      t.integer :uuid, index: true, null: false

      t.timestamps
    end
    add_index :advances, [:empresa_id, :cliente_id, :uuid], unique: true

    reversible do |dir|
      dir.up do
        #add a foreign key
        execute <<-SQL
          ALTER TABLE ADVANCES ADD CONSTRAINT FK_ADVANCES_CLIENTE_ID FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTES (ID)
        SQL
        execute <<-SQL
          ALTER TABLE ADVANCES ADD CONSTRAINT FK_ADVANCES_EMPRESA_ID FOREIGN KEY (EMPRESA_ID) REFERENCES EMPRESAS (ID)
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE ADVANCES DROP CONSTRAINT FK_ADVANCES_CLIENTE_ID 
        SQL
        execute <<-SQL
          ALTER TABLE ADVANCES DROP CONSTRAINT FK_ADVANCES_EMPRESA_ID 
        SQL
      end
    end

  end
end
