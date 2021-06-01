# Stop Chef client.
execute 'Stop Chef client' do
  command <<-EOH
    supervisorctl stop chef-client
    supervisorctl remove chef-client
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?'/etc/supervisord.d/chef-client.ini'
  end
end
