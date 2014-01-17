class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login, limit: 30
      t.references :empresa, index: true
      t.references :cidade, index: true

      t.timestamps
    end
    add_index :users, :login, unique: true
    execute <<-SQL
      ALTER TABLE USERS ADD CONSTRAINT FK_USERS_EMPRESA_ID FOREIGN KEY (EMPRESA_ID) REFERENCES EMPRESAS (ID)
    SQL
    execute <<-SQL
      ALTER TABLE USERS ADD CONSTRAINT FK_USERS_CIDADE_ID FOREIGN KEY (CIDADE_ID) REFERENCES CIDADES (ID)
    SQL
  end
end
