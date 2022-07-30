require 'google/api_client/client_secrets'

class ApiToken < ApplicationRecord
  belongs_to :user

  scope :valid, -> { where(expiry: ..DateTime.now) }

  encrypts :api_access_token
  encrypts :api_refresh_token

  validates :user_id, uniqueness: true
  validates :api_access_token, :api_refresh_token, :expiry_at, :provider, presence: true

  def expired?
    expiry_at < DateTime.now
  end

  # @param [] auth
  def update_tokens!(auth)
    update(
      api_access_token: auth.access_token,
      api_refresh_token: auth.refresh_token,
      expiry_at: auth.expires_at
    )
  end

  def authorization
    @authorization ||= secrets.to_authorization
  end

  def refresh
    refresh! if expired?
  end
  def refresh!
    authorization.refresh!
    update_tokens!(authorization)
  end

  private

  def secrets
    options = {
      'web' => {
        'access_token' => api_access_token,
        'refresh_token' => api_refresh_token,
        'client_id' => ENV['GOOGLE_CLIENT_ID'],
        'client_secret' => ENV['GOOGLE_CLIENT_SECRET']
      }
    }
    Google::APIClient::ClientSecrets.new(options)
  end

end
