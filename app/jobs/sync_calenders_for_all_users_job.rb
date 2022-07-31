class SyncCalendersForAllUsersJob < ApplicationJob

  def perform
    User.pluck(:id).find_each(&:sync_google_calender_events)
  end
end
