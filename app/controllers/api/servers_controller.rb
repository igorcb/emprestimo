class Api::ServersController < ApiController

  def is_active
  	@notice = { notice: "OK" }
    render json: @notice.to_json, status:200
  end
end