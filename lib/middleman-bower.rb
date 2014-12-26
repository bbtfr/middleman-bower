require 'bower-rails'
require 'bower-rails/performer'

# Require core library
require 'middleman-core'
require "middleman-bower/commands"


# Extension namespace
class Middleman::Bower < ::Middleman::Extension

  def after_configuration
    bowerfile = File.join("Bowerfile")

    if File.exist?(bowerfile)
      dsl = BowerRails::Dsl.evalute(BowerRails.root_path, bowerfile)
      dsl.final_assets_path.map do |assets_root, assets_path|
        app.sprockets.append_path File.join app.root, assets_root, assets_path, 'bower_components'
      end
    else
      %w(lib vendor).each do |dir|
        app.sprockets.append_path File.join app.root, dir, 'bower_components'
      end
    end
  end

end

# Register extensions which can be activated
# Make sure we have the version of Middleman we expect
# Name param may be omited, it will default to underscored
# version of class name
Middleman::Bower.register(:bower)
