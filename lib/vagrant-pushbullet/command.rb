require "washbullet"

module VagrantPlugins
  module Pushbullet
    class Command < Vagrant.plugin("2", :command)

      def self.synopsis
        "generates Pushbullet configration file   weeeeeeeeeeee"
      end
      
      def execute
        config_file = ::VagrantPlugins::Pushbullet.config_file

        if config_file.exist?

          @env.ui.warn("Welcome to the Pushbullet Setup Guide")

          guide = <<-INFO
This command helps you configure Pushbullet via it's config file: #{config_file}

To limit notifications to specific devices:
  - If your token is correct you will see your devices below. 
  - Add/remove device id's from the list shown below to: '#{config_file}'. 
To notify all devices:
  - Leave the DEVICES variable empty in your config file.
INFO
          @env.ui.info(guide)
          require config_file

          wb_client = get_washbullet_client(PushbulletConfig::TOKEN,config_file)
          return if wb_client == nil

          enabled_devices = PushbulletConfig::DEVICES

          devices = wb_client.devices.body["devices"]
          msg = []
          devices.each { |device| 
            if device["active"] 
              devices = PushbulletConfig::DEVICES
              enabled = "\e[32m Enabled"
              disabled = "\e[31m Disabled"
              enabled_theme = enabled_devices.include?(device['iden'])? enabled : disabled
              enabled_theme = enabled if enabled_devices.size == 0
              msg << "   #{enabled_theme}: '#{device['nickname']}' id:    #{device['iden']} \e[0m"
            end
          }
          msg = msg.join("\n")
          @env.ui.info(msg)
        else
          ::VagrantPlugins::Pushbullet.write_default_key
          @env.ui.error("Please put your pushbullet token from http://pushbullet.com/account into this file: #{config_file}. 
            \n  ---- Then run this command again to limit pushes to specific devices-----")
        end
      end

      private

      def get_washbullet_client(api_token,config_file)
        if (api_token.nil? || api_token.empty?)
          @env.ui.error("Your API Token is not set. \nYou can find it here: http://pushbullet.com/account \nAnd enter it here: #{config_file}")
          return nil
        end

        begin
          client = Washbullet::Client.new(api_token)
        rescue Washbullet::Unauthorized
          @env.ui.error("Pushbullet API Authentication failed. Please compare your API Token: http://pushbullet.com/account with: #{config_file}")
          return nil
        rescue Exception => e
          @env.ui.error("There was an unknown exception with the Pushbullet plugin.  \n Please report this to https://github.com/brettswift/vagrant-pushbullet")
          raise e
        end

      end  
    end          
  end
end        
