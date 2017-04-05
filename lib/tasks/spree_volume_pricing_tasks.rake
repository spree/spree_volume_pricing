require 'generators/spree_volume_pricing/install/install_generator'
namespace :spree_volume_pricing do
  desc "Install spree_volume_pricing migrations and backend/js"
  task :install do
    g = SpreeVolumePricing::Generators::InstallGenerator.new
    g.add_javascripts
    g.add_migrations
    SpreeVolumePricing::Generators::InstallGenerator.run_migrations
  end
end
