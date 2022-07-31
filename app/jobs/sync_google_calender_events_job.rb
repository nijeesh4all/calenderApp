class SyncGoogleCalenderEventsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    @user = User.find(user_id)
    service = GoogleCalenderService.new(@user)
    events_list = service.fetch_calender_events
    events_list.items.each { |event_item| create_event(event_item)  }
  end

  # @param [Google::Apis::CalendarV3::Event] event_item
  def create_event(event_item)
    event = @user.events.find_or_initialize_by(event: event_item.id)
    event_attributes = Event.extract_event_attributes(event_item)
    event.update(event_attributes)
  end

end
