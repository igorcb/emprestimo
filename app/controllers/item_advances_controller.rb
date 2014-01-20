class ItemAdvancesController < ApplicationController
  before_action :signed_in_user

  respond_to :html

  def index
	#@clientes = current_user.empresa_id.nil? ? Cliente.where(empresa_id: -1) : Cliente.where(empresa_id: current_user.empresa_id).order(:nome)
    advances = Advance.all
	  @clientes = current_user.empresa_id.nil? ? Cliente.where(empresa_id: -1) : Cliente.where('id in (?) and empresa_id = ? and cidade = ?', advances.ids, current_user.empresa_id, current_user.cidade.nome)
  end

  def item_advance_by_cliente
  	#@item_advance = ItemAdvance.joins(:cliente).where("DATE(data_vencimento) = ? and clientes.id = ?", Date.today.to_s, params[:id])
  	@item_advance = ItemAdvance.joins(:cliente).where("DATE(data_vencimento) = ? and clientes.id = ?", '2014-01-13', params[:id])
    respond_with(@item_advance) do |format|
      format.html { render :layout => !request.xhr? }
    end
  end
  def update
    @item_advance = ItemAdvance.find(params[:parcela_id])
    respond_to do |format|
      #if @item_advance.update_attributes(data_pagamento: Date.today.to_s, valor_pago: params[:valor_pago])
      if @item_advance.update_attributes(data_pagamento: '2014-01-10', valor_pago: params[:valor_pago])
        format.html { redirect_to item_advances_path, notice: 'ItemAdvance was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end  

  private
    def signed_in_user
      redirect_to signin_url, notice: "Por favor efetuar o login." unless signed_in?
    end

end
