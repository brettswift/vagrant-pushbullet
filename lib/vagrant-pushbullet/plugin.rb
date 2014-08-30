begin
  require "vagrant"
rescue LoadError
  raise "The Vagrant Pushbullet plugin must be run within Vagrant."
end

module VagrantPlugins
  module Pushbullet

    class Plugin < Vagrant.plugin("2")
      name "Pushbullet"
      description <<-DESC
      This plugin add a Pushbullet notification to your vagrant command.
      This notificates `up` or `provision` is over.
      DESC

      #TODO replace this with 'set token' that takes a param. 
      command "pushbullet-config" do
        require_relative "command"
        Command
      end

      action_hook("Pushbullet_hook", :machine_action_up) do |hook|
        require_relative "action"
        hook.prepend(Action)
      end

      action_hook("Pushbullet_hook", :machine_action_provision) do |hook|
        require_relative "action"
        hook.prepend(Action)
      end

      action_hook("Pushbullet_hook", :machine_action_reload) do |hook|
        require_relative "action"
        hook.prepend(Action)
      end

      config(:Pushbullet) do
        require_relative "config"
        Config
      end
    end
  end
end
