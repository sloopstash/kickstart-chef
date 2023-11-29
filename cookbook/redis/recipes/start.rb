system_dir = node['redis']['system_dir']
supervisor_exec_dir = node['system']['supervisor']['exec_dir']

supervisor_client_path = "#{supervisor_exec_dir}/supervisorctl"
init_conf_path = "#{system_dir}/supervisor.ini"

execute 'Start Redis' do
  command <<-EOH
    #{supervisor_client_path} update redis
    #{supervisor_client_path} start redis
  EOH
  user 'root'
  group 'root'
  returns [0]
  action 'run'
  only_if do
    File.exists?init_conf_path
  end
end
