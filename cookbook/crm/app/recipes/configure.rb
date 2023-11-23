deploy_dir = node['app']['deploy_dir']
nginx_config_dir = node['app']['nginx']['config_dir']

# Configure App for Redis.
template "#{deploy_dir}/config/redis.conf" do
  source 'redis.conf.erb'
  owner 'root'
  group 'root'
  mode 0600
  backup false
  action 'create'
end

# Configure Nginx for App.
template "#{nginx_config_dir}/conf.d/app.conf" do
  source 'nginx/app.conf.erb'
  owner 'root'
  group 'root'
  variables(
    'deploy_dir'=>deploy_dir
  )
  mode 0600
  backup false
  action 'create'
end

# Configure Supervisor for App.
template '/etc/supervisord.d/app.ini' do
  source 'supervisor.ini.erb'
  owner 'root'
  group 'root'
  variables(
    'deploy_dir'=>deploy_dir
  )
  mode 0600
  backup false
  action 'create'
end
