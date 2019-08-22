# default attributes.
default['app']['repo_url'] = 'https://github.com/sloopstash/kickstart-flask'
default['app']['deploy_dir'] = '/opt/app'
default['app']['nginx'] = {
  'version' => '1.14.0-1',
  'config_dir' => '/etc/nginx'
}
