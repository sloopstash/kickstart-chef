# start chef push jobs client.
execute 'start chef push jobs client' do
  command <<-EOH
    supervisorctl reread chef-push-jobs-client
    supervisorctl update chef-push-jobs-client
    supervisorctl start chef-push-jobs-client
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?'/etc/supervisord.d/chef-push-jobs-client.ini'
  end
end
