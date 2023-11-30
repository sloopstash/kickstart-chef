release_version = node['nginx']['release_version']

root_dir = node['nginx']['root_dir']
log_dir = node['nginx']['log_dir']
conf_dir = node['nginx']['conf_dir']
script_dir = node['nginx']['script_dir']
system_dir = node['nginx']['system_dir']
exec_dir = node['nginx']['exec_dir']

download_url = "https://nginx.org/packages/rhel/7/x86_64/RPMS/nginx-#{release_version}-1.el7_4.ngx.x86_64.rpm"
package_path = "/tmp/nginx-#{release_version}-1.el7_4.ngx.x86_64.rpm"
server_path = "#{exec_dir}/nginx"

# Download Nginx.
remote_file package_path do
  source download_url
  mode 0644
  not_if do
    File.exists?package_path
  end
end

# Install Nginx.
yum_package 'Install Nginx' do
  source package_path
  action 'install'
  not_if do
    File.exists?server_path
  end
end

# Delete Nginx source.
execute 'Delete Nginx source' do
  command "rm -f #{package_path}"
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?package_path
  end
end

# Create Nginx directories.
[
  root_dir,
  log_dir,
  conf_dir,
  script_dir,
  system_dir
].each do |dir|
  directory dir do
    owner 'root'
    group 'root'
    recursive true
    mode 0700
    action 'create'
    not_if do
      File.exists?dir
    end
  end
end
