module Middleman
  module Cli

    # This class provides a "bower" command for the middleman CLI.
    class Bower < Thor
      include Thor::Actions

      check_unknown_options!

      namespace :bower

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end
      def self.source_root
        File.join(File.dirname(__FILE__), 'templates')
      end

      desc "bower init [options]", "Adds a boilerplate bower.json or Bowerfile to the root of Middleman project"
      def init config_file_name='bowerfile'
        case config_file_name
        when 'bowerfile' then template 'Bowerfile',  'Bowerfile'
        when 'json'      then template 'bower.json', 'bower.json'
        else
          raise ArgumentError, 'You can setup middleman-bower only using bower.json or Bowerfile. Please provide `json` or `bowerfile` as an argument instead'
        end
        empty_directory "vendor/assets"
        append_to_file "config.rb", "\nactivate :bower\n"
      end

      desc "bower install [options]", "Install bower components"
      def install install_type_name='development', *options
        thor = self
        case install_type_name
        when 'deployment'
          BowerRails::Performer.perform false do |bower|
            thor.run "#{bower} install #{options.join}"
          end
        when 'development'
          BowerRails::Performer.perform do |bower|
            thor.run "#{bower} install #{options.join}"
          end
        when 'production'
          BowerRails::Performer.perform do |bower|
            thor.run "#{bower} install -p #{args[:options]}"
          end
        end
      end

      desc "bower list", "List bower components"
      def list
        thor = self
        BowerRails::Performer.perform false do |bower|
          thor.run "#{bower} list"
        end
      end

      desc "bower update [options]", "Update bower components"
      def update prune=nil, *options
        thor = self
        if prune == "prune"
          BowerRails::Performer.perform do |bower|
            thor.run "#{bower} update #{options.join} && #{bower} prune #{options.join}"
          end
        else
          BowerRails::Performer.perform do |bower|
            thor.run "#{bower} update #{options.join}"
          end
        end
      end

      desc "bower resolve [options]", "Resolve assets paths in bower components"
      def resolve *options
        thor = self
        BowerRails::Performer.perform false do
          resolve_asset_paths
        end
      end

      desc "bower clean [options]", "Attempt to keep only files listed in 'main' of each component's bower.json"
      def clean *options
        BowerRails::Performer.perform false do
          remove_extra_files
        end
      end

      def help
        list = self.class.printable_tasks(false).sort! { |a, b| a[0] <=> b[0] }

        shell.say 'Tasks:'
        shell.print_table(list, ident: 2, truncate: true)
        shell.say
      end

      desc "bower TASK", "Middleman Bower related tasks"
      def bower meth='help', *args
        klass, task = Thor::Util.find_class_and_task_by_namespace("bower:#{meth}")

        if klass.nil?
          raise Thor::Error, "There's no '#{meth}' command for Middleman::Bower. Try 'middleman bower help' for a list of commands."
        else
          args.unshift(meth) if meth
          klass.start(args, shell: shell)
        end
      end

    end

  end
end