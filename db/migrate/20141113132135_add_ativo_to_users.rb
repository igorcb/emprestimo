class AddAtivoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ativo, :integer, default: 0
  end

end
