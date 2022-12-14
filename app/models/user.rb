class User < ApplicationRecord
  # allow only sign-in and signup via OAuth
  devise :omniauthable, omniauth_providers: %i[google_oauth2]

  has_one :api_token, dependent: :destroy
  has_many :events

  accepts_nested_attributes_for :api_token

  after_create_commit :sync_google_calender_events

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.full_name = auth.info.name
      user.avatar_url = auth.info.image
      user.api_token_attributes = {
        api_access_token: auth.credentials.token,
        api_refresh_token: auth.credentials.refresh_token,
        expiry_at: Time.zone.at(auth.credentials.expires_at),
        provider: auth.provider
      }
    end
  end

  def sync_google_calender_events
    SyncGoogleCalenderEventsJob.perform_later(id)
  end
end
