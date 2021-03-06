module SpreeVariantOptions
  module Generators
    class InstallGenerator < Rails::Generators::Base

      desc "Installs required migrations for spree_essentials"
      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_variant_options'
      end

      def run_migrations
         res = ask "Would you like to run the migrations now? [Y/n]"
         if res == "" || res.downcase == "y"
           run 'bundle exec rake db:migrate'
         else
           puts "Skipping rake db:migrate, don't forget to run it!"
         end
      end

      def add_javascripts
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/spree_variant_options\n"
        append_file 'vendor/assets/javascripts/spree/backend/all.js', "//= require spree/backend/spree_variant_options\n"
      end

      def add_stylesheets
        insert_into_file 'vendor/assets/stylesheets/spree/frontend/all.css', " *= require spree/frontend/spree_variant_options\n", :before => /\*\//, :verbose => true
        insert_into_file 'vendor/assets/stylesheets/spree/backend/all.css', " *= require spree/backend/spree_variant_options\n", :before => /\*\//, :verbose => true
      end

    end
  end
end
