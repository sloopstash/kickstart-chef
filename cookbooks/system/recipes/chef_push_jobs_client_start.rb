Chef::Log.info '***** start chef push-jobs client. *****'
# start chef push-jobs client using supervisorctl.
execute 'start chef push-jobs client' do
  command <<-EOH
    #{node['system']['supervisor']['bin_path']} reread chef-push-jobs-client
    #{node['system']['supervisor']['bin_path']} add chef-push-jobs-client
    #{node['system']['supervisor']['bin_path']} start chef-push-jobs-client
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?"#{node['system']['supervisor']['configs_dir']}/chef-push-jobs-client.ini"
  end
end