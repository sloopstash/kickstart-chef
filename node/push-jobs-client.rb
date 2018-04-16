chef_server_url  "https://chef-server/organizations/sloopstash"
validation_client_name "chef-validator"
log_location   STDOUT
node_name "redis-node-1"
trusted_certs_dir "/etc/chef/trusted_certs"
whitelist = {
  "chef-client" => "chef-client -j /etc/chef/run-list.json"
}