Chef::Log.info '***** stop chef push-jobs client. *****'
# stop chef push-jobs client using supervisorctl.
execute 'stop chef push-jobs client' do
  command <<-EOH
    #{node['system']['supervisor']['bin_path']} stop chef-push-jobs-client
    #{node['system']['supervisor']['bin_path']} remove chef-push-jobs-client
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?"#{node['system']['supervisor']['configs_dir']}/chef-push-jobs-client.ini"
  end
end
