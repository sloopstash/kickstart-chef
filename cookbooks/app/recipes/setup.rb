deploy_dir = node['app']['deploy_dir']
nginx_version = node['app']['nginx']['version']
nginx_config_dir = node['app']['nginx']['config_dir']

# download nginx.
remote_file "/tmp/nginx-#{nginx_version}.el7_4.ngx.x86_64.rpm" do
  source "https://nginx.org/packages/rhel/7/x86_64/RPMS/nginx-#{nginx_version}.el7_4.ngx.x86_64.rpm"
  mode 0644
  not_if do
    File.exists?"/tmp/nginx-#{nginx_version}.el7_4.ngx.x86_64.rpm"
  end
end

# install nginx.
yum_package 'install nginx' do
  source "/tmp/nginx-#{nginx_version}.el7_4.ngx.x86_64.rpm"
  action :install
end

# configure nginx.
template "#{nginx_config_dir}/nginx.conf" do
  source 'nginx/nginx.conf.erb'
  owner 'root'
  group 'root'
  mode 0600
  backup false
  action 'create'
end

# configure supervisor for nginx.
template '/etc/supervisord.d/nginx.ini' do
  source 'nginx/supervisor.ini.erb'
  owner 'root'
  group 'root'
  mode 0600
  backup false
  action 'create'
end

# install git.
yum_package 'install git' do
  package_name ['git']
  action :install
end

# create app deploy directory.
directory deploy_dir do
  owner 'root'
  group 'root'
  recursive true
  mode 0600
  action 'create'
  not_if do
    File.exists?deploy_dir
  end
end
