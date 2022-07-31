class Event < ApplicationRecord
  belongs_to :user

  enum created_from: [:request, :sync], _prefix: true

  validates_presence_of :start_date_time, :end_date_time, :title

  after_create_commit :register_event_webhook, :publish_event_to_google_calender
  after_update_commit :publish_event_changes_to_google_calender

  def register_event_webhook
    SubscribeGoogleEventsWebhookJob.perform_later(user_id, id) if event?
  end

  def event?
    event.present?
  end

  private

  def publish_event_to_google_calender
    PublishEventToGoogleJob.perform_later(id) unless created_from_sync?
  end

  def publish_event_changes_to_google_calender
    PublishEventChangesToGoogleJob.perform_later(id)
  end

end
