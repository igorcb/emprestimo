class ItemAdvance < ActiveRecord::Base
  belongs_to :advance
  has_one :cliente, through: :advance
  validates :empresa_id, presence: true
  validates :advance_id, presence: true
  validates :parcela, presence: true
  validates :data_vencimento, presence: true
  validates :valor, presence: true
  validates :atraso, presence: true
  validates :status, presence: true	
  validates :uuid, presence: true, uniqueness: {scope: :empresa_id}
  

  def diferenca
    self.valor * self.atraso
  end
end
