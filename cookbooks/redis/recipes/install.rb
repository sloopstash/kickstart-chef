Chef::Log.info '***** install redis. *****'
# install system packages required by redis.
yum_package 'install system packages' do
  package_name ['jemalloc','tcl']
  action :install
end

# create redis directories in loop.
[
  node['redis']['configs_dir'],
  node['redis']['system_dir'],
  node['redis']['logs_dir'],
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

# extract redis from downloaded source.
execute 'extract redis source from archive' do
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

# compile and install redis from the downloaded source.
execute 'compile and install redis from source' do
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

# cleanup the source and archives.
execute 'cleanup build' do
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