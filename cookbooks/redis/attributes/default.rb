# default attributes.
default['redis'] = {
  'configs_dir'=>'/etc/redis',
  'system_dir'=>'/var/run/redis',
  'data_dir'=>'/var/lib/redis',
  'logs_dir'=>'/var/log/redis'
}
default['redis']['version'] = '4.0.8'