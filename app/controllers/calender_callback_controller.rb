class CalenderCallbackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    callback_request = WebhookRequestResponse.new(request, params)

    ProcessWebhookRequestJob.perform_later(callback_request.event_id) if callback_request.state_exists?

    render :nothing, status: :ok
  end
end
