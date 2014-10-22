require "pathname"
require "vagrant-pushbullet/version"
require "vagrant-pushbullet/plugin"

module VagrantPlugins
  module Pushbullet

    def self.config_file
      vag_home = Pathname.new(File.expand_path("~", __FILE__))
      Pathname.new("#{vag_home}/.vagrant.d/pushbullet.rb")
    end

    def self.write_default_key
      content = <<-EOF
module PushbulletConfig
  TOKEN = "" #required
  DEVICES = [] #optional. MUST use quotes. NO empty strings.
end
EOF
      #TODO: write default config file again. 
      File.open(config_file,'w') do |f|
        f.puts content
      end
    end

  end
end
