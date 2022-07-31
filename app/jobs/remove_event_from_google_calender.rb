class RemoveEventFromGoogleCalender < ApplicationJob
  def perform(user_id, event_token)
    @user = User.find(user_id)
    service = GoogleCalenderService.new(@user)
    service.remove_calender_event(event_token)
  end
end
