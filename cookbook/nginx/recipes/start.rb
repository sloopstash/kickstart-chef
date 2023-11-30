system_dir = node['nginx']['system_dir']
supervisor_exec_dir = node['system']['supervisor']['exec_dir']

supervisor_client_path = "#{supervisor_exec_dir}/supervisorctl"
init_conf_path = "#{system_dir}/supervisor.ini"

# Start Nginx. 
execute 'Start Nginx' do
  command <<-EOH
    #{supervisor_client_path} update nginx
    #{supervisor_client_path} start nginx
  EOH
  user 'root'
  group 'root'
  returns [0,1]
  action 'run'
  only_if do
    File.exists?init_conf_path
  end
end
