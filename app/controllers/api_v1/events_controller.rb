class ApiV1::EventsController < ApiController
  before_action :authenticate_user!

  def index
    render json: { message: "Hi. #{current_user.id}" }
  end
end
