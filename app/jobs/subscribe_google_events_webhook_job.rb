class SubscribeGoogleEventsWebhookJob < ApplicationJob
  queue_as :default

  def perform(event_id)
    event = Event.find(event_id)

    service = GoogleCalenderService.new(event.user)
    service.watch_calender_event(event)
  end

end
