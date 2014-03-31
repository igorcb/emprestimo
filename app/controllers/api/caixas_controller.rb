class Api::CaixasController < ApiController
  def index
	@caixas = Caixa.all
	render json: @caixas
  end

  def show
  	@caixa = Caixa.find params[:id]
    render json: @caixa.to_json 
  end

  def create
    begin
      @caixa = Caixa.new(params[:caixa])
      empresa_id = params[:caixa][:empresa_id]
      puts ">>>>>>>>>>>>>>>> #{@caixa.to_json}"
      if @caixa.save
      	puts ">>>>>>>>>>>>>>>> Caixa was successfully created."
        render notice: 'Caixa was successfully created.'
      else
        @errors = { :errors => @caixa.errors.each {|m| m.to_s} }
        puts ">>>>>>>>>>>>>>>> @errors.to_json"
        render json: @errors.to_json, :status => 200
      end
    rescue Exception => e
      @errors = { :errors => "create, record empresa: #{ empresa_id } and caixa uuid: #{@caixa.descricao} not found" }
      render json: @errors.to_json, :status => 200
    end 

  end  

  def update
    begin
      @caixa = Caixa.find_by_empresa_id_and_uuid(params[:caixa][:empresa_id],params[:caixa][:uuid])
      if @caixa.update_attributes(params[:caixa])
        render notice: 'Caixa was successfully updated.'
      else
        @errors = { :errors => @caixa.errors.each {|m| m.to_s} }
        render json: @errors.to_json, :status => 200
      end
    rescue Exception => e
      @errors = { :errors => "update caixa, record empresa: #{ empresa_id } and caixa uuid: #{@caixa.descricao} not found" }
      render json: @errors.to_json, :status => 200
    end
  end

end