class CalenderCallbackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    callback_request = WebhookRequestResponse.new(request, params)

  end
end
