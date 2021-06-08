current_dir = File.dirname(__FILE__)
local_mode false
config_log_level :error
config_log_location "/var/log/chef/client-stdout.log"
node_name "tuto"
client_key "#{current_dir}/secret/tuto.pem"
chef_server_url "https://chef-infra-server.sloopstash-dev.internal/organizations/sloopstash"
cookbook_path ["#{current_dir}/cookbook"]
knife[:editor] = "vim"
