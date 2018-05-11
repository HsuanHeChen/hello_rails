class ApiV1::EventsController < ApiController
  before_action :authenticate_user!

  def index
    render json: { message: "Hi." }
  end
end
