class Api::AdvancesController < ApiController


	def index
		@advances = Advance.all
	  render json: @advances
  end

  def show
  	@advance = Advance.find params[:id]
    render json: @advance.to_json 
  end

  def create
    begin
      @advance = Advance.new(params[:advance])
      empresa_id = params[:advance][:empresa_id]
      cliente_id = params[:advance][:cliente_id]
      cliente = Cliente.find_by_empresa_id_and_uuid(params[:advance][:empresa_id],params[:advance][:cliente_id])
      @advance.cliente_id = cliente.id
      if @advance.save
        render notice: 'Advance was successfully created.'
      else
        @errors = { :errors => @advance.errors.each {|m| m.to_s} }
        render json: @errors.to_json, :status => 200
      end
    rescue Exception => e
      @errors = { :errors => "create, record empresa: #{ empresa_id } and cliente: #{cliente_id} not found" }
      render json: @errors.to_json, :status => 200
    end 

  end  

  def update
    ##@advance = Advance.find(params[:id])
    begin
      @advance = Advance.find_by_empresa_id_and_uuid(params[:advance][:empresa_id],params[:advance][:uuid])
      if @advance.update_attributes(params[:advance])
        render notice: 'Advance was successfully updated.'
      else
        @errors = { :errors => @advance.errors.each {|m| m.to_s} }
        render json: @errors.to_json, :status => 200
      end
    rescue Exception => e
      @errors = { :errors => 'update, record not found' }
      render json: @errors.to_json, :status => 200
    end
  end

  def advances_uuid
    @advances = Advance.where(uuid: [params[:advance]])
    render json: @advances
  end

  def destroy
    begin
      @advance = Advance.find_by_empresa_id_and_uuid(params[:empresa_id],params[:id])
      @advance.destroy
      @notice = { notice: "advance was successfully deleted" }
      render json: @notice.to_json, status:200
    rescue Exception => e
      @errors = { :errors => "unable to delete the advance"}
      render json: @errors.to_json, status: 200
    end
  end
end