current_dir = File.dirname(__FILE__)
log_level                 :info
log_location              STDOUT
node_name                 "tuto"
client_key                "#{current_dir}/secret/tuto.pem"
chef_server_url           "https://chef-infra-server/organizations/sloopstash"
cookbook_path             ["#{current_dir}/cookbook"]
