deploy_dir = node['app']['deploy_dir']
nginx_config_dir = node['app']['nginx']['config_dir']

# configure app for redis.
template "#{deploy_dir}/config/redis.conf" do
  source 'redis.conf.erb'
  owner 'root'
  group 'root'
  mode 0600
  backup false
  action 'create'
end

# configure nginx for app.
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

# configure supervisor for app.
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
