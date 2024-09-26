root_dir = node['app']['root_dir']
source_dir = node['app']['source_dir']
log_dir = node['app']['log_dir']
script_dir = node['app']['script_dir']
system_dir = node['app']['system_dir']

# Install Python.
yum_package 'Install Python' do
  package_name [
    'python-2.7.18',
    'python-devel',
    'python-pip',
    'python-setuptools'
  ]
  action 'install'
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
