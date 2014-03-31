class Api::LancamentoCaixasController < ApiController
  def index
    @lancamento_caixas = Lancamentocaixa.all
    render json: @lancamento_caixas.to_json
  end

  def show
    @lancamento_caixa = LancamentoCaixa.find params[:id]
    render json: @lancamento_caixa.to_json
  end

  def create
    begin

      @lancamento_caixa = LancamentoCaixa.new(params[:lancamento_caixa])
      empresa_id = params[:lancamento_caixa][:empresa_id]
      caixa_id = params[:lancamento_caixa][:caixa_id]
      caixa = Caixa.find_by_empresa_id_and_uuid(empresa_id, caixa_id)
      @lancamento_caixa.caixa_id = caixa.id

      if @lancamento_caixa.save
        render notice: 'LancamentoCaixa was successfully created.'
      else
        @errors = { :errors => @lancamento_caixa.errors.each {|m| m.to_s} }
        render json: @errors.to_json, :status => 200
      end
    rescue Exception => e
      @errors = { :errors => "create, lancamento_caixa record empresa: #{ empresa_id } and caixa: #{caixa_id} not found" }
      render json: @errors.to_json, :status => 200
    end
  end  

end