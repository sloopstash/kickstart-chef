Chef::Log.info '***** start redis. *****'
# start redis using supervisorctl.
execute 'start redis' do
  command <<-EOH
    #{node['system']['supervisor']['bin_path']} reread redis
    #{node['system']['supervisor']['bin_path']} update redis
    #{node['system']['supervisor']['bin_path']} start redis
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?"#{node['system']['supervisor']['configs_dir']}/redis.ini"
  end
end