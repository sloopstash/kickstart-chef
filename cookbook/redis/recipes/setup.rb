release_version = node['redis']['release_version']

root_dir = node['redis']['root_dir']
data_dir = node['redis']['data_dir']
log_dir = node['redis']['log_dir']
conf_dir = node['redis']['conf_dir']
script_dir = node['redis']['script_dir']
system_dir = node['redis']['system_dir']
source_dir = "/tmp/redis-#{release_version}"

download_url = "http://download.redis.io/releases/redis-#{release_version}.tar.gz"
archive_path = "/tmp/redis-#{release_version}.tar.gz"

# Install system packages.
yum_package 'Install system packages' do
  package_name ['tcl']
  action 'install'
end

# Download Redis.
remote_file archive_path do
  source download_url
  mode 0644
  not_if do
    File.exists?archive_path
  end
end

# Extract Redis.
execute 'Extract Redis' do
  command "tar xvzf #{archive_path} -C /tmp"
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?archive_path
  end
end

# Compile and install Redis.
execute 'Compile and install Redis' do
  command <<-EOH
    make distclean
    make
    make install
  EOH
  cwd source_dir
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?source_dir
  end
end

# Delete Redis source.
execute 'Delete Redis source' do
  command 'rm -rf redis-*'
  cwd '/tmp'
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?source_dir
  end
end

# Create Redis directories.
[
  root_dir,
  data_dir,
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
