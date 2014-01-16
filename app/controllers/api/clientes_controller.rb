class Api::ClientesController < ApiController
  #before_filter :authenticate
  # Configuring charset to UTF-8 
  #before_filter :configure_charsets 
  
  def configure_charsets 
     headers["Content-Type"] = "application/json; charset=ASCII"
  end 

	def index
		@clientes = Cliente.all
		
    respond_to do |format|
      format.json { render json: @clientes }
    end
  end

  def show
  	@cliente = Cliente.find params[:id]
    
		respond_to do |format|
	    format.json { render json: @cliente.to_json }
	  end
  end

  def create
    @cliente = Cliente.new(params[:cliente])

    if @cliente.save
      render(notice: 'cliente was successfully created.');
    else
      @errors = { :errors => @cliente.errors.each {|m| m.to_s} }
      render(:json => @errors.to_json, :status => 200)      
    end
  end  

  def clientes_uuid
    @clientes = Cliente.where(uuid: [params[:cliente]])
    respond_to do |format|
      format.json { render json: @clientes }
    end
  end
end