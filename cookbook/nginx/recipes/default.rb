# Include recipes.
include_recipe 'nginx::setup'
include_recipe 'nginx::configure'
include_recipe 'nginx::stop'
include_recipe 'nginx::start'
