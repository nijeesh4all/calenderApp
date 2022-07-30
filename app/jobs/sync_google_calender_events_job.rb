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
    start_time = event_item.start.date_time
    end_time = event_item.end.date_time

    event = @user.events.find_or_initialize_by(event: event_item.id)
    event.update(
      title: event_item.summary,
      description: event_item.description,
      start_date_time: start_time,
      end_date_time: end_time,
      event: event_item.id,
      event_source: 'google'
    )
  end

end
