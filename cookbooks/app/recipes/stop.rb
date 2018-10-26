# stop app.
execute 'stop app' do
  command <<-EOH
    supervisorctl stop app
    supervisorctl remove app
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?'/etc/supervisord.d/app.ini'
  end
end

# stop nginx.
execute 'stop nginx' do
  command <<-EOH
    supervisorctl stop nginx
    supervisorctl remove nginx
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?'/etc/supervisord.d/nginx.ini'
  end
end
