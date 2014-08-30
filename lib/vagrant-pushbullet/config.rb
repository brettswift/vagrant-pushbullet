require "net/https"

module VagrantPlugins
  module Pushbullet
    class Config < Vagrant.plugin("2", :config)
      
      # API parameters
      attr_accessor :token    
      attr_accessor :message  

      def initialize
        super

        @token     = UNSET_VALUE

        @config_file = UNSET_VALUE
      end

      def set
        yield self if block_given?
      end
 

      def validate(machine)
        errors = []
        @config_file = ::VagrantPlugins::Pushbullet.config_file

        unless @config_file && @config_file.exist?
        
          errors << "Pushbullet configuration file created at:  #{@config_file}"
          errors << "run `pushbullet-config` for assistance on entering required values in that file."
          errors << "\n       --- you will not see this error again ----"
          ::VagrantPlugins::Pushbullet.write_default_key
        end

        require @config_file
        @token = PushbulletConfig::TOKEN

        {Pushbullet: errors}
      end

      def attributes
        [  @token  ]
      end

      def is_config_valid
          attributes.each do |attribute|
            return true if attribute != UNSET_VALUE
          end
          false
      end

      def finalize!
        @token     = nil                     if @token     == UNSET_VALUE   
      end
    end
    
  end
end
        
