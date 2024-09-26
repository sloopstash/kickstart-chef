infrastructure_type = node['system']['infrastructure']['type']
infrastructure_provider = node['system']['infrastructure']['provider']
infrastructure_service = node['system']['infrastructure']['service']

supervisor_conf_dir = node['system']['supervisor']['conf_dir']
supervisor_exec_dir = node['system']['supervisor']['exec_dir']

supervisor_client_path = "#{supervisor_exec_dir}/supervisorctl"
supervisor_server_path = "#{supervisor_exec_dir}/supervisord"

# Stop Chef infra client.
execute 'Stop Chef infra client' do
  command <<-EOH
    #{supervisor_client_path} stop chef-infra-client
    #{supervisor_client_path} remove chef-infra-client
  EOH
  user 'root'
  group 'root'
  returns [0,1]
  action 'run'
  only_if do
    File.exists?"#{supervisor_conf_dir}/chef-infra-client.ini"
  end
end

if infrastructure_type==('cloud'||'on-premise')
  case infrastructure_provider
    when 'aws','host'
      if infrastructure_service==('ec2'||'virtualbox')
        # Stop Supervisor.
        execute 'Stop Supervisor' do
          command "#{supervisor_client_path} shutdown"
          user 'root'
          group 'root'
          returns [0,1]
          action 'run'
          only_if do
            File.exists?supervisor_client_path
          end
          only_if do
            File.exists?supervisor_server_path
          end
        end
      end
    else
      nil
  end
end
