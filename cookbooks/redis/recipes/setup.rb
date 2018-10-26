# install system packages.
yum_package 'install system packages' do
  package_name ['tcl']
  action :install
end

# create redis directories.
[
  node['redis']['config_dir'],
  node['redis']['system_dir'],
  node['redis']['log_dir'],
  node['redis']['data_dir']
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

# download redis.
remote_file "/tmp/redis-#{node['redis']['version']}.tar.gz" do
  source "http://download.redis.io/releases/redis-#{node['redis']['version']}.tar.gz"
  mode 0644
  not_if do
    File.exists?"/tmp/redis-#{node['redis']['version']}.tar.gz"
  end
end

# extract redis.
execute 'extract redis' do
  command "tar xvzf redis-#{node['redis']['version']}.tar.gz"
  cwd '/tmp'
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?"/tmp/redis-#{node['redis']['version']}.tar.gz"
  end
end

# compile and install redis.
execute 'compile and install redis' do
  command <<-EOH
    make distclean
    make
    make install
  EOH
  cwd "/tmp/redis-#{node['redis']['version']}"
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?"/tmp/redis-#{node['redis']['version']}"
  end
end

# cleanup source.
execute 'cleanup source' do
  command 'rm -rf redis-*'
  cwd '/tmp'
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?"/tmp/redis-#{node['redis']['version']}"
  end
end
