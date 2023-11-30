environment = node['app']['environment']
external_domain = node['app']['external_domain']
conf_files = Array.new

source_dir = node['app']['source_dir']
log_dir = node['app']['log_dir']
conf_dir = "#{source_dir}/config"
system_dir = node['app']['system_dir']
supervisor_conf_dir = node['system']['supervisor']['conf_dir']

init_conf_path = "#{system_dir}/supervisor.ini"

# Configure App.
conf_files.push('app.conf')
conf_files.each do |file|
  template "#{conf_dir}/#{file}" do
    source "#{file}.erb"
    owner 'root'
    group 'root'
    variables(
      'environment'=>environment,
      'external_domain'=>external_domain
    )
    mode 0600
    backup false
    action 'create'
  end
end

# Configure Supervisor for App.
template init_conf_path do
  source 'supervisor.ini.erb'
  owner 'root'
  group 'root'
  variables(
    'source_dir'=>source_dir,
    'log_dir'=>log_dir
  )
  mode 0600
  backup false
  action 'create'
end

# Symlink Supervisor configuration.
execute 'Symlink Supervisor configuration' do
  command "ln -sf #{init_conf_path} #{supervisor_conf_dir}/app.ini"
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?init_conf_path
  end
end
