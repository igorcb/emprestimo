class ItemAdvancesController < ApplicationController
  before_action :signed_in_user

  respond_to :html

  def index
	  #@clientes = current_user.empresa_id.nil? ? Cliente.where(empresa_id: -1) : Cliente.where('empresa_id = ? and cidade = ?', current_user.empresa_id, current_user.cidade.nome)
    @item_advances = ItemAdvance.joins(:cliente).where("DATE(data_vencimento) = ? and clientes.cidade = ?", Date.today.to_s, current_user.cidade.nome).order('advances.data, advances.uuid')    
  end

  def select_city
    @cidades = Cliente.cidades(current_user.empresa_id)
  end

  def summary_city
    @item_advances = ItemAdvance.joins(:cliente).select("clientes.cidade as cidade, sum(item_advances.valor) as valor, sum(item_advances.valor_pago) as valor_pago").where("DATE(data_vencimento) = ? and advances.empresa_id = ?", Date.today.to_s, current_user.empresa_id).group("clientes.cidade").order('clientes.cidade')
  end
 
  def select_client
    @clientes = current_user.empresa_id.nil? ? Cliente.where(empresa_id: -1) : Cliente.where('empresa_id = ? and cidade = ?', current_user.empresa_id, current_user.cidade.nome)
  end

  def item_advance_by_cliente
    @cliente = Cliente.find(params[:id])
  	@item_advance = ItemAdvance.joins(:cliente).where("DATE(data_vencimento) = ? and clientes.id = ?", Date.today.to_s, params[:id])
    respond_with(@item_advance) do |format|
      format.html { render :layout => !request.xhr? }
    end
  end

  def item_advance_by_city
    @item_advances = ItemAdvance.joins(:advance, :cliente).where("DATE(data_vencimento) = ? and clientes.cidade = ?", Date.today.to_s, params[:id]).order('advances.data, advances.uuid')
    respond_with(@item_advances) do |format|
      format.html { render :layout => !request.xhr? }
    end
  end

  def cobranca_diaria_by_city
    item_advance_by_city
  end

  def edit
    @item_advance = ItemAdvance.find(params[:id])
  end

  def update
    if params[:valor_pago].blank?
      redirect_to select_client_path, :flash => { :danger => "Informe o valor da parcela" } 
      return
    end 
    @item_advance = ItemAdvance.find(params[:parcela_id])
    respond_to do |format|
      if @item_advance.update_attributes(data_pagamento: Date.today.to_s, valor_pago: params[:valor_pago])
        flash[:success] = "Parcela foi atualizada com sucesso."
        #format.html { redirect_to item_advances_path, success: 'ItemAdvance was successfully updated.' }
        format.html { redirect_to select_client_path }
      else
        format.html { render action: 'edit' }
      end
    end
  end  

end
