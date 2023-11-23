# Start App.
execute 'Start App' do
  command <<-EOH
    supervisorctl update app
    supervisorctl start app
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?'/etc/supervisord.d/app.ini'
  end
end

# Start Nginx.
execute 'Start Nginx' do
  command <<-EOH
    supervisorctl update nginx
    supervisorctl start nginx
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?'/etc/supervisord.d/nginx.ini'
  end
end
