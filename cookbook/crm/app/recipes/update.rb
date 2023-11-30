revision = node['app']['revision']

source_dir = node['app']['source_dir']

repo_url = node['app']['repo_url']

# Fetch App Git repository.
git source_dir do
  repository repo_url
  revision revision
  user 'root'
  group 'root'
  enable_checkout true
  action 'sync'
end

# Install Python packages.
execute 'Install Python packages' do
  command <<-EOH
    pip install flask==0.12.4
    pip install redis==2.10.6
    pip install elastic-apm[flask]==3.0.5
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
end
