stack = node['nginx']['stack']
external_domain = node['nginx']['external_domain']

log_dir = node['nginx']['log_dir']
conf_dir = node['nginx']['conf_dir']
system_dir = node['nginx']['system_dir']
app_source_dir = node['app']['source_dir']
supervisor_conf_dir = node['system']['supervisor']['conf_dir']

server_conf_path = "#{conf_dir}/server.conf"
app_conf_path = "#{conf_dir}/app.conf"
init_conf_path = "#{system_dir}/supervisor.ini"
server_pid_path = "#{system_dir}/process.pid"

# Configure Nginx.
template server_conf_path do
  source 'server.conf.erb'
  owner 'root'
  group 'root'
  variables(
    'pid_path'=>server_pid_path
  )
  mode 0600
  backup false
  action 'create'
end

# Configure Nginx for App.
template app_conf_path do
  source "#{stack}/app.conf.erb"
  owner 'root'
  group 'root'
  variables(
    'stack'=>stack,
    'external_domain'=>external_domain,
    'app_source_dir'=>app_source_dir,
    'log_dir'=>log_dir
  )
  mode 0600
  backup false
  action 'create'
end

# Create empty PID file.
execute 'Create empty PID file' do
  command "touch #{server_pid_path}"
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  not_if do
    File.exists?server_pid_path
  end
end

# Configure Supervisor for Nginx.
template init_conf_path do
  source 'supervisor.ini.erb'
  owner 'root'
  group 'root'
  variables(
    'server_pid_path'=>server_pid_path
  )
  mode 0600
  backup false
  action 'create'
end

# Symlink Nginx server configuration.
execute 'Symlink Nginx server configuration' do
  command "ln -sf #{server_conf_path} /etc/nginx/nginx.conf"
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?server_conf_path
  end
end

# Symlink Nginx configuration for App.
execute 'Symlink Nginx configuration for App' do
  command "ln -sf #{app_conf_path} /etc/nginx/conf.d/app.conf"
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?app_conf_path
  end
end

# Symlink Supervisor configuration.
execute 'Symlink Supervisor configuration' do
  command "ln -sf #{init_conf_path} #{supervisor_conf_dir}/nginx.ini"
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?init_conf_path
  end
end
