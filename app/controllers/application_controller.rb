class ApplicationController < ActionController::API
  def define_behavior_to_broadcast(service, broadcast, status, include_list = [])
    service.on(broadcast) do |data|
      render json: data, status: status, include: include_list
    end
  end
end
