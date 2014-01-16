class Empresa < ActiveRecord::Base
  has_many :advances
  validates :nome, presence: true, uniqueness: true
end
