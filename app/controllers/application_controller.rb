class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def order_by(empresa)
    case empresa
      when 1 then order = 'advances.data, advances.uuid'    
      when 2 then order = 'clientes.nome'
      when 3 then order = 'clientes.nome'
    end
  	order
  end
end
