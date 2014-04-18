class AdvancesController < ApplicationController
  before_action :signed_in_user

  respond_to :html

  def index
  	@cidades = Cliente.cidades(current_user.empresa_id)
  	#@cidades = Cliente.cidades(current_user.empresa_id)
  	#@advances = Advance.where(empresa_id: current_user.empresa_id).order('data')
  end

  def advance_by_city
    case current_user.empresa_id
      when 1 then order = "advances.data"
      when 2 then order = "clientes.nome"
    end

    @advances = Advance.includes(:cliente).where("advances.empresa_id = ? and clientes.cidade = ?", current_user.empresa_id, params[:id]).references(:cliente).order(order)
    respond_with(@advances) do |format|
      format.html { render :layout => !request.xhr? }
    end
  end

  def show
  	@advance = Advance.find(params[:id])
  end

end
