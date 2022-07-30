class Event < ApplicationRecord
  belongs_to :user

  attr_accessor :event_source

  validates_presence_of :start_date_time, :end_date_time, :title

  after_create_commit :publish_event_to_google_calender,
                      :register_event_webhook

  def register_event_webhook
    SubscribeGoogleEventsWebhookJob.perform_later(user_id, id) if event?
  end

  private

  def publish_event_to_google_calender
    return if event?

    PublishEventToGoogleJob.perform_later(id)
  end

  def event?
    event.present?
  end
end
