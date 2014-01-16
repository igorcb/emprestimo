class Cidade < ActiveRecord::Base
  belongs_to :empresa
  validates :nome, presence: true, uniqueness: true
  validates :sabado, presence: true
end
