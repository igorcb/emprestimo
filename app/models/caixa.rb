class Caixa < ActiveRecord::Base
  has_many :lancamento_caixas

  def status_nome
  	case self.status
  	  when 0 then "Aberto"
  	  when 1 then "Fechado"
  	end
  end
end
