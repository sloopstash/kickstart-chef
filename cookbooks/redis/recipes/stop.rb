# stop redis.
execute 'stop redis' do
  command <<-EOH
    supervisorctl stop redis
    supervisorctl remove redis
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?'/etc/supervisord.d/redis.ini'
  end
end
