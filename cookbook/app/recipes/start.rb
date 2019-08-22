# start app.
execute 'start app' do
  command <<-EOH
    supervisorctl reread app
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

# start nginx.
execute 'start nginx' do
  command <<-EOH
    supervisorctl reread nginx
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
