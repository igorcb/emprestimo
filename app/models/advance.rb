class Advance < ActiveRecord::Base
  belongs_to :cliente
  has_many :item_advances, dependent: :delete_all
  validates :empresa_id, presence: true
  validates :cliente_id, presence: true, uniqueness: {scope: :empresa_id}
  validates :data, presence: true
  validates :valor, presence: true
  validates :saldo, presence: true
  validates :parcelas, presence: true
  validates :uuid, presence: true, uniqueness: {scope: :empresa_id}
  
end
