# start push-jobs client.
execute 'start push-jobs client' do
  command <<-EOH
    supervisorctl reread push-jobs-client
    supervisorctl update push-jobs-client
    supervisorctl start push-jobs-client
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?'/etc/supervisord.d/push-jobs-client.ini'
  end
end
