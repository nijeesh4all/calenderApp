class ProcessWebhookRequestJob < ApplicationJob
  queue_as :default

  def perform(event_id)
    event = Event.find(event_id)
    user = event.user

    service = GoogleCalenderService.new(user)

    service.refresh_event!(event)
  end
end
