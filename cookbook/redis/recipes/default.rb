# Include recipes.
include_recipe 'redis::setup'
include_recipe 'redis::configure'
include_recipe 'redis::stop'
include_recipe 'redis::start'
