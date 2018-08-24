Chef::Log.info '***** configure redis. *****'
# redis directories.
configs_dir = node['redis']['configs_dir']
system_dir = node['redis']['system_dir']
logs_dir = node['redis']['logs_dir']
data_dir = node['redis']['data_dir']

# create redis configuration file.
template "#{configs_dir}/redis.conf" do
  source 'redis.conf.erb'
  owner 'root'
  group 'root'
  variables(
    'pid_file'=>"#{system_dir}/process.pid",
    'log_file'=>"#{logs_dir}/redis.log",
    'data_dir'=>data_dir
  )
  mode 0600
  backup false
  action 'create'
end

# create empty pid file.
execute 'create pid file' do
  command "touch #{system_dir}/process.pid"
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  not_if do
    File.exists?"#{system_dir}/process.pid"
  end
end

# create supervisor configuration file for redis.
template "#{node['system']['supervisor']['configs_dir']}/redis.ini" do
  source 'supervisor.ini.erb'
  owner 'root'
  group 'root'
  variables(
    'configs_dir'=>configs_dir,
    'system_dir'=>system_dir
  )
  mode 0644
  backup false
  action 'create'
end
