# Vagrant Pushbullet

This gem is a [Vagrant](http://www.vagrantup.com/) plugin that adds Pushbullet notifications to configured devices. 

## Setup Pushbullet

* First get a Pushbullet Account, and add devices to it. 
    - [Pushbullet.com](https://www.pushbullet.com/)
* Download the *iOS* app,  *Chrome* plugin, *Android* app, and more.  Add those to your Pushbullet account. 
* Get your HTTP API Token:  http://pushbullet.com/account

## Install Plugin

```bash
$ vagrant plugin install vagrant-pushbullet
```

## Plugin Usage

This plugin is configured purely by a configuration file in your home directory. 
The plugin will create this file for you, but you will have to edit it manually (for now). 

`~/.vagrant.d/pushbullet.rb`
```ruby
module PushbulletConfig
  TOKEN = "replace this text with token from pushbullet.com/account" #required
  DEVICES = ['asdfasdfasdf','asdfasdfasdf'] #optional
end
```

Run `vagrant pushbullet-config` to retrieve your Device ID's.  Add those to the DEVICES array in the config file to limit which devices are notified. 
 

## Notifications

A notification is sent after these commands complete: 

* note there is currently a bug where if an exception occurs in the provisioning, the notification is not sent. 

- `vagrant up`
- `vagrant reload --provision`
- `vagrant provision`

## Contributing

* use feature branches please.  Prefer  feature/your_feature_name
* submit pull requests to the `develop` branch


## Author

Brett Swift

## Kudos 

[tcnksm](https://twitter.com/deeeet)
    - for his vagrant-pushover plugin. This plugin is modeled after his. 