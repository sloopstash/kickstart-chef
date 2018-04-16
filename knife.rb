current_dir = File.dirname(__FILE__)
log_level                 :info
log_location              STDOUT
node_name                 "devops"
client_key                "#{current_dir}/secrets/devops.pem"
chef_server_url           "https://chef-server/organizations/sloopstash"
cookbook_path             ["#{current_dir}/cookbooks"]