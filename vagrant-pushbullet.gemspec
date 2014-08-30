# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-pushbullet/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-pushbullet"
  spec.version       = VagrantPlugins::Pushbullet::VERSION
  spec.authors       = ["brettswift"]
  spec.email         = ["brettswift@gmail.com"]
  spec.summary       = %q{Vagrant plugin that adds Pushbullet notifications }
  spec.description   = %q{Vagrant plugin that adds Pushbullet notifications }
  spec.homepage      = "https://github.com/brettswift/vagrant-pushbullet"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency 'washbullet', '~> 0.3.1'
end
