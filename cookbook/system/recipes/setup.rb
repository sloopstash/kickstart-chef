infrastructure_type = node['system']['infrastructure']['type']
infrastructure_provider = node['system']['infrastructure']['provider']
infrastructure_service = node['system']['infrastructure']['service']

if infrastructure_type==('cloud'||'on-premise')
  case infrastructure_provider
    when 'aws','host'
      if infrastructure_service==('ec2'||'virtualbox')
        # Remove Postfix service.
        execute 'Remove Postfix service' do
          command <<-EOH
            systemctl stop postfix.service
            systemctl disable postfix.service
          EOH
          user 'root'
          group 'root'
          returns [0,1]
          action 'run'
          only_if do
            File.exists?'/sbin/postfix'
          end
        end

        # Enable netfilter Linux kernel module.
        execute 'Enable netfilter Linux kernel module' do
          command 'modprobe br_netfilter'
          user 'root'
          group 'root'
          returns [0]
          action 'run'
        end

        # Disable Linux swap memory.
        execute 'Disable Linux swap memory' do
          command 'swapoff -a'
          user 'root'
          group 'root'
          returns [0]
          action 'run'
        end
      end
    else
      nil
  end
end

# Install Git.
yum_package 'Install Git' do
  package_name ['git']
  action 'install'
end

# Include recipes.
include_recipe 'system::configure'
include_recipe 'system::start'
