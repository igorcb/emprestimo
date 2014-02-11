class User < ActiveRecord::Base
  belongs_to :empresa
  belongs_to :cidade
  has_secure_password
  validates :login, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :password, length: { minimum: 3 }, if: :password_digest_changed?
  #validates :empresa_id, presence: true
  #validates :cidade_id, presence: true
  before_create :create_remember_token

  module Nivel
    ADMIN = 0
    SUPERVISOR = 1
    COBRADOR = 2
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end  
end
