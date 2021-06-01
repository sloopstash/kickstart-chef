# Start Chef client.
execute 'Start Chef client' do
  command <<-EOH
    supervisorctl update chef-client
    supervisorctl start chef-client
  EOH
  user 'root'
  group 'root'
  returns [0,7]
  action 'run'
  only_if do
    File.exists?'/etc/supervisord.d/chef-client.ini'
  end
end
