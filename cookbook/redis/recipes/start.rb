# Start Redis.
execute 'Start Redis' do
  command <<-EOH
    supervisorctl update redis
    supervisorctl start redis
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?'/etc/supervisord.d/redis.ini'
  end
end
