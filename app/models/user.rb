class User < ApplicationRecord

  # allow only sign-in and signup via OAuth
  devise :omniauthable, omniauth_providers: %i[google_oauth2]
end
