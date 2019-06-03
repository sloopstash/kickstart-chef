# stop push-jobs client.
execute 'stop push-jobs client' do
  command <<-EOH
    supervisorctl stop push-jobs-client
    supervisorctl remove push-jobs-client
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?'/etc/supervisord.d/push-jobs-client.ini'
  end
end
