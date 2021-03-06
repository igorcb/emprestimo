class AdvancesController < ApplicationController
  before_action :signed_in_user

  respond_to :html

  def index
  	@cidades = Cliente.cidades(current_user.empresa_id)
  	#@cidades = Cliente.cidades(current_user.empresa_id)
  	#@advances = Advance.where(empresa_id: current_user.empresa_id).order('data')
  end

  def advance_by_city
    @advances = Advance.includes(:cliente).where("advances.empresa_id = ? and clientes.cidade = ?", current_user.empresa_id, params[:id]).references(:cliente).order(order_by(current_user.empresa_id))
    respond_with(@advances) do |format|
      format.html { render :layout => !request.xhr? }
    end
  end

  def show
  	@advance = Advance.find(params[:id])
  end

end
