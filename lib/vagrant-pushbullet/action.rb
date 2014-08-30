require "net/https"
require "washbullet"

module VagrantPlugins
  module Pushbullet
    class Action

      def initialize(app,env)
        @app     = app
        @ui      = env[:ui]
        @machine = env[:machine].name.to_s
        @machinfo = env[:machine]
      end

      def call(env)
        # Before machine action
        state  = env[:machine].state.id

        # Execute machine action
        @app.call(env)

        # After execute machine action
        config    = env[:machine].config.Pushbullet
        action    = env[:machine_action]
        provision = env[:provision_enabled]

        config_file = ::VagrantPlugins::Pushbullet.config_file

        unless config_file.exist?  &&  config.is_config_valid
          puts "some validation failed"
          env[:ui].error("Pushbullet plugin configuration has not yet been set up. \nPlease replace required values in config file: #{config_file} ")
        end

        case action
        when :up
          notification(config, config_file) if state != :running && provision && config.is_config_valid
        when :reload
          notification(config, config_file) if provision && config.is_config_valid
        when :provision
          notification(config, config_file) if config.is_config_valid
        end
      end

      def notification(config, config_file)
        #TODO: append provisioning result, success or fail.
        require config_file
        devices = PushbulletConfig::DEVICES
        token = PushbulletConfig::TOKEN
        client = Washbullet::Client.new(token)
        if(devices.length > 0)
          devices.each {|iden|
            client.push_note(iden, "Vagrant Finished:  #{@machine}", '')
          }
        else 
            #push to all 
            client.push_note('', "Vagrant Finished:  #{@machine}", '')
        end

      end
    end
  end
end

