deploy_dir = node['app']['deploy_dir']
repo_url = node['app']['repo_url']

# Fetch App Git repository.
git deploy_dir do
  repository repo_url
  revision 'master'
  user 'root'
  group 'root'
  enable_checkout false
  action 'sync'
end

# Install App Python packages.
execute 'Install App Python packages' do
  command 'pip install -r requirements.txt'
  cwd deploy_dir
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?"#{deploy_dir}/requirements.txt"
  end
end
