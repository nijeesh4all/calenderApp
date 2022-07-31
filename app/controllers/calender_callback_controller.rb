class CalenderCallbackController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_callback_request, :set_event

  def create
    return head(:not_found) unless @event.present?

    ProcessWebhookRequestJob.perform_later(@callback_request.event_id) if @callback_request.state_exists?
    head :ok
  end

  private

  def set_callback_request
    @callback_request = WebhookRequestResponse.new(request, params)
  end
  def set_event
    @event ||= @callback_request.event
  end
end
