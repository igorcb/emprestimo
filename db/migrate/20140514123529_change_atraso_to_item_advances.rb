class ChangeAtrasoToItemAdvances < ActiveRecord::Migration
  def self.up
    change_table :item_advances do |t|
      t.change :atraso, :decimal, precision: 10, scale: 2, null: false
    end
  end
  def self.down
    change_table :item_advances do |t|
      t.change :atraso, :integer, null: false
    end
  end
end
