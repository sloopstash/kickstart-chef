Chef::Log.info '***** stop redis. *****'
# stop redis using supervisorctl.
execute 'stop redis' do
  command <<-EOH
    #{node['system']['supervisor']['bin_path']} stop redis
    #{node['system']['supervisor']['bin_path']} remove redis
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?"#{node['system']['supervisor']['configs_dir']}/redis.ini"
  end
end