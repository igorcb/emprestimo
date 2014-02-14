class Cliente < ActiveRecord::Base
   belongs_to :empresa
   has_many :advances
   validates :empresa_id, presence: true
   validates :nome, presence: true, uniqueness: {scope: :empresa_id}
   validates :cidade, presence: true
   validates :uuid, presence: true, uniqueness: {scope: :empresa_id}

   scope :cidade, -> cidade { where(cidade: cidade) }
   scope :empresa, -> empresa { where(empresa_id: empresa) }

   scope :cidades, -> empresa { select('cidade as id, cidade').uniq('cidade').where(empresa_id: empresa).order('cidade') }
   
   #scope :unique_title, select("id, title").group("title")
   
end
