class PublishEventChangesToGoogleJob < ApplicationJob
  def perform(event_id)
    event = Event.find(event_id)
    user = event.user

    service = GoogleCalenderService.new(user)

    service.update_google_calender_event(event)
  end
end
