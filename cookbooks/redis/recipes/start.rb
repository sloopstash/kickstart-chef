# start redis.
execute 'start redis' do
  command <<-EOH
    supervisorctl reread redis
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
