# Include recipes.
include_recipe 'app::setup'
include_recipe 'app::update'
include_recipe 'app::configure'
include_recipe 'app::stop'
include_recipe 'app::start'
