class Event < ApplicationRecord
  belongs_to :user

  enum created_from: [:request, :sync], _prefix: true

  validates_presence_of :start_date_time, :end_date_time, :title

  after_create_commit :register_event_webhook, :publish_event_to_google_calender
  after_update_commit :publish_event_changes_to_google_calender
  after_destroy_commit :remove_event_from_google_calender

  def register_event_webhook
    SubscribeGoogleEventsWebhookJob.perform_later(id) if created_from_request?
  end

  def event?
    event.present?
  end

  def refresh!
    GoogleCalenderService.new(user.api_token).fetch_event(self)
  end

  # @param [Google::Apis::CalendarV3::Event] google_event
  def self.extract_event_attributes(google_event, created_from: :sync)
    start_time = google_event.start.date_time
    end_time = google_event.end.date_time
    {
      title: google_event.summary,
      description: google_event.description,
      start_date_time: start_time,
      end_date_time: end_time,
      event: google_event.id,
      created_from: created_from
    }
  end

  private

  def publish_event_to_google_calender
    PublishEventToGoogleJob.perform_later(id) unless created_from_sync?
  end

  def publish_event_changes_to_google_calender
    PublishEventChangesToGoogleJob.perform_later(id)
  end

  def remove_event_from_google_calender
    RemoveEventFromGoogleCalender.perform_later(user_id, event.event) if created_from_request?
  end

end
