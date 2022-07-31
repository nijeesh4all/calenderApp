Sidekiq.configure_server do |config|
  config.redis = {
    host: ENV['REDIS_HOST'],
    port: ENV['REDIS_PORT'] || '6379'
  }

  # for sidekiq cron
  config.on(:startup) do
    schedule_file = "config/users_schedule.yml"

    if File.exist?(schedule_file)
      Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
    end
  end

end

Sidekiq.configure_client do |config|
  config.redis = {
    host: ENV['REDIS_HOST'],
    port: ENV['REDIS_PORT'] || '6379'
  }
end

