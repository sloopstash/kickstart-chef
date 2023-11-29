supervisor_conf_dir = node['system']['supervisor']['conf_dir']
supervisor_exec_dir = node['system']['supervisor']['exec_dir']

supervisor_client_path = "#{supervisor_exec_dir}/supervisorctl"
supervisor_server_path = "#{supervisor_exec_dir}/supervisord"
supervisor_conf_path = node['system']['supervisor']['conf_path']

if infrastructure_type==('cloud'||'on-premise')
  case infrastructure_provider
    when 'aws','host'
      if infrastructure_service==('ec2'||'virtualbox')
        # Start Supervisor.
        execute 'Start Supervisor' do
          command "#{supervisor_server_path} -c #{supervisor_conf_path}"
          user 'root'
          group 'root'
          returns [0,2]
          action 'run'
          only_if do
            File.exists?supervisor_server_path
          end
          only_if do
            File.exists?supervisor_conf_path
          end
        end
      end
    else
      nil
  end
end

# Start Chef infra client.
execute 'Start Chef infra client' do
  command <<-EOH
    #{supervisor_client_path} update chef-client
    #{supervisor_client_path} start chef-client
  EOH
  user 'root'
  group 'root'
  returns [0,7]
  action 'run'
  only_if do
    File.exists?"#{supervisor_conf_dir}/chef-infra-client.ini"
  end
end
