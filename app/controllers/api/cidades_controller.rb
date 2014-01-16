class Api::CidadesController < ApiController
  #before_filter :authenticate

	def index
		@cidades = Cidade.all
	 render json: @cidades
  end

  def show
  	@cidade = Cidade.find params[:id]
    render json: @cidade.to_json
  end

  def create
    @cidade = Cidade.new(params[:cidade])

    if @cidade.save
      render notice: 'Cidade was successfully created.'
    else
      @errors = { errors: @cidade.errors.each {|m| m.to_s} }
      render json: @errors.to_json, status: 200
    end
  end  

  def cidades_uuid
    @cidades = Cidade.where(uuid: [params[:cidade]])
    render json: @cidades
  end
end