set :output, "log/cron_log.log"
env :PATH, ENV["PATH"]
env :RBENV_ROOT, ENV["RBENV_ROOT"]
env :RBENV_VERSION, ENV["RBENV_VERSION"]

every 1.day do
  rake "batch:send_messages RAILS_ENV=development"
end
