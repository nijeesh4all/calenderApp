class WebhookRequestResponse
  attr_accessor :params, :headers

  def initialize(request, params)
    @headers  = request.headers
    @params   = params
  end

  def event
    @event ||= Event.where(id: event_id, event: event_token).first
  end

  def event_id
    params[:id]
  end

  def state_exists?
    state == 'exists'
  end

  def state_sync?
    state == 'sync'
  end

  def state
    headers['HTTP_X_GOOG_RESOURCE_STATE']
  end

  def event_token
    headers['x-goog-channel-token']
  end
end
