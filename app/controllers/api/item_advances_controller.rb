class Api::ItemAdvancesController < ApiController
  def index
	@item_advances = ItemAdvance.all
	render json: @item_advances.to_json
  end

  def show
  	@cliente = Cliente.first
  	@item_advance = ItemAdvance.find params[:id]
    render json: @item_advance.to_json
    #respond_to do |format|
    #  format.json { render json: @item_advance }
    #end
  end

  def create
    begin
      @item_advance = ItemAdvance.new(params[:item_advance])
      empresa_id = params[:item_advance][:empresa_id]
      advance_id = params[:item_advance][:advance_id]
      advance = Advance.find_by_empresa_id_and_uuid(params[:item_advance][:empresa_id],params[:item_advance][:advance_id])
      @item_advance.advance_id = advance.id
      @item_advance.status = 'A'

      if @item_advance.save
        render notice: 'ItemAdvance was successfully created.'
      else
        @errors = { :errors => @item_advance.errors.each {|m| m.to_s} }
        render json: @errors.to_json, :status => 200
      end
    rescue Exception => e
      @errors = { :errors => "create, record empresa: #{ empresa_id } and advance: #{advance_id} not found" }
      render json: @errors.to_json, :status => 200
    end
  end  

  def update
    begin
    @item_advance = ItemAdvance.find_by_empresa_id_and_uuid(params[:item_advance][:empresa_id],params[:item_advance][:uuid])
    if @item_advance.update_attributes(params[:item_advance])
      render(notice: 'item_advance was successfully updated.');
    else
      @errors = { :errors => @item_advance.errors.each {|m| m.to_s} }
      render json: @errors.to_json, status: 200
    end
    rescue Exception => e
      @errors = { :errors => 'update, record not found' }
      render json: @errors.to_json, :status => 200
    end

  end  

  def item_advances_today_and_city
    #@item_advances = ItemAdvance.joins(:cliente).where(uuid: [params[:item_advance]])
    @item_advances = ItemAdvance.joins(:cliente).where("DATE(data_pagamento) = ? and clientes.cidade = ? and item_advances.empresa_id = ?", params[:data_pagamento], params[:cidade], params[:empresa])
    respond_to do |format|
      format.json { render json: @item_advances }
    end
  end

  def destroy
    begin
      @item_advance = ItemAdvance.find_by_empresa_id_and_uuid(params[:empresa_id],params[:id])
      @item_advance.destroy
      @notice = { notice: "item_advance was successfully deleted" }
      render json: @notice.to_json, status:200
    rescue Exception => e
      @errors = { :errors => "unable to delete the item_advance"}
      render json: @errors.to_json, status: 200
    end
  end

end