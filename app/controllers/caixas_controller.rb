class CaixasController < ApplicationController
  before_action :signed_in_user

  respond_to :html

  def index
  	@cidades = Cliente.cidades(current_user.empresa_id)
  	#@cidades = Cliente.cidades(current_user.empresa_id)
  	@caixas = Caixa.where(empresa_id: current_user.empresa_id).order('data_abertura desc')
  end

  #def advance_by_city
  #  @advances = Advance.joins(:cliente).where("clientes.cidade = ?", params[:id])
  #  respond_with(@advances) do |format|
  #    format.html { render :layout => !request.xhr? }
  #  end
  #end

  def show
  	@caixa = Caixa.find(params[:id])
  end

end
