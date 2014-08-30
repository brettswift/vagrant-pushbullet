require "bundler/gem_tasks"
require 'rubygems'
require 'bundler/setup'

version = VagrantPlugins::Pushbullet::VERSION

desc "Install your plugin to your system vagrant."
task :install_plugin do
  Rake::Task[:build].execute
  system("/usr/bin/vagrant plugin install pkg/vagrant-pushbullet-#{version}.gem")
end

task :uninstall_plugin do
  system("/usr/bin/vagrant plugin uninstall vagrant-pushbullet")
end

Bundler::GemHelper.install_tasks

# alias
task :i => :install_plugin
task :u => :uninstall_plugin

