# stop chef push jobs client.
execute 'stop chef push jobs client' do
  command <<-EOH
    supervisorctl stop chef-push-jobs-client
    supervisorctl remove chef-push-jobs-client
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?'/etc/supervisord.d/chef-push-jobs-client.ini'
  end
end
