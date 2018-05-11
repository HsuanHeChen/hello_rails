class ApiV1::EventsController < ApiController
  before_action :authenticate_user!
end
