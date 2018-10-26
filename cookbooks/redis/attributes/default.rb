# default attributes.
default['redis'] = {
  'version' => '4.0.9',
  'config_dir' => '/etc/redis',
  'system_dir' => '/var/run/redis',
  'data_dir' => '/var/lib/redis',
  'log_dir' => '/var/log/redis'
}


user = {
  'name' => 'john',
  'age' => 29,
  'work' => 'professional',
  'languages' => ['tamil','english'],
  'emplyment' => {
    'comp_1' => 'tbw',
    'comp_2' => 'sloop'
  }
}