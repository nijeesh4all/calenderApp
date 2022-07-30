class ApiToken < ApplicationRecord
  belongs_to :user

  encrypts :api_access_token
  encrypts :api_refresh_token
end
