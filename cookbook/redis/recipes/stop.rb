system_dir = node['redis']['system_dir']
supervisor_exec_dir = node['system']['supervisor']['exec_dir']

supervisor_client_path = "#{supervisor_exec_dir}/supervisorctl"
init_conf_path = "#{system_dir}/supervisor.ini"

execute 'Stop Redis' do
  command <<-EOH
    #{supervisor_client_path} stop redis
    #{supervisor_client_path} remove redis
  EOH
  user 'root'
  group 'root'
  returns [0,1]
  action 'run'
  only_if do
    File.exists?init_conf_path
  end
end
