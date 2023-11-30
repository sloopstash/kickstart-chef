data_dir = node['redis']['data_dir']
log_dir = node['redis']['log_dir']
conf_dir = node['redis']['conf_dir']
system_dir = node['redis']['system_dir']
supervisor_conf_dir = node['system']['supervisor']['conf_dir']

server_conf_path = "#{conf_dir}/server.conf"
init_conf_path = "#{system_dir}/supervisor.ini"
server_log_path = "#{log_dir}/server.log"
server_pid_path = "#{system_dir}/process.pid"

# Configure Redis.
template server_conf_path do
  source 'server.conf.erb'
  owner 'root'
  group 'root'
  variables(
    'data_dir'=>data_dir,
    'pid_path'=>server_pid_path,
    'log_path'=>server_log_path
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

# Configure Supervisor for Redis.
template init_conf_path do
  source 'supervisor.ini.erb'
  owner 'root'
  group 'root'
  variables(
    'server_conf_path'=>server_conf_path,
    'server_pid_path'=>server_pid_path
  )
  mode 0600
  backup false
  action 'create'
end

# Symlink Supervisor configuration.
execute 'Symlink Supervisor configuration' do
  command "ln -sf #{init_conf_path} #{supervisor_conf_dir}/redis.ini"
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?init_conf_path
  end
end
