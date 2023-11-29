infrastructure_type = node['system']['infrastructure']['type']
infrastructure_provider = node['system']['infrastructure']['provider']
infrastructure_service = node['system']['infrastructure']['service']
system_user = node['system']['user']
kernel_params = node['system']['kernel']
security_limit_params = node['system']['security_limit']
organization = node['system']['organization']

kernel_conf_path = "/etc/sysctl.d/90-#{organization}.conf"
security_limit_conf_path = "/etc/security/limits.d/10-#{organization}.conf"

if infrastructure_type==('cloud'||'on-premise')
  case infrastructure_provider
    when 'aws','host'
      if infrastructure_service==('ec2'||'virtualbox')
        # Set required Linux kernel params.
        template kernel_conf_path do
          source 'kernel.conf.erb'
          owner 'root'
          group 'root'
          variables(
            'params'=>kernel_params
          )
          mode 0600
          backup false
          action 'create'
          notifies 'run','execute[Apply required Linux kernel params]','immediately'
        end

        # Apply required Linux kernel params.
        execute 'Apply required Linux kernel params' do
          command "sysctl -p #{kernel_conf_path}"
          user 'root'
          group 'root'
          returns [0,255]
          action 'nothing'
        end

        # Set required Linux security limit params.
        template security_limit_conf_path do
          source 'security-limit.conf.erb'
          owner 'root'
          group 'root'
          variables(
            'system_user'=>system_user,
            'params'=>security_limit_params
          )
          mode 0600
          backup false
          action 'create'
        end
      end
    else
      nil
  end
end
