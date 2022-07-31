require "google/apis/calendar_v3"

class GoogleCalenderService
  attr_reader :user, :api_token, :service

  DEFAULT_CALENDER = 'primary'.freeze

  # @param [User] user
  def initialize(user)
    @user = user
    @api_token = user.api_token
    @calender_service = Google::Apis::CalendarV3::CalendarService.new
    @calender_service.authorization = @api_token.authorization
  end

  # @param [Event] event
  def create_google_calender_event(event)
    result = @calender_service.insert_event(DEFAULT_CALENDER, construct_event(event))
    event.update(event: result.id)
    event.register_event_webhook
  end

  def update_google_calender_event(event)
    @calender_service.update_event(DEFAULT_CALENDER, event.event, construct_event(event))
  end

  def fetch_calender_events
    @calender_service.list_events(DEFAULT_CALENDER)
  end

  private


  def construct_event(event)
    Google::Apis::CalendarV3::Event.new(
      summary: event.title,
      description: event.description,
      start: google_time_format(event.start_date_time),
      end: google_time_format(event.start_date_time)
    )
  end

  # @param [DateTime] date_time
  def google_time_format(date_time)
    Google::Apis::CalendarV3::EventDateTime.new(
      date_time: date_time.iso8601
    )
  end
end
