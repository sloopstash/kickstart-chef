root_dir = node['app']['root_dir']
source_dir = node['app']['source_dir']
log_dir = node['app']['log_dir']
script_dir = node['app']['script_dir']
system_dir = node['app']['system_dir']

# Install Python.
execute 'Install Python' do
  command <<-EOH
    yum install python-2.7.18
    yum install python-devel
    yum install python-pip
    yum install python-setuptools
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
end

# Create App directories.
[
  root_dir,
  source_dir,
  log_dir,
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
