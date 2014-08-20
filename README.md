# Honeybadger::Splitproject

Modification to Honeybadger gem that allows notifying multiple honeybadger projects from single Rails project.

## Installation

Add this line to your application's Gemfile:

    gem 'honeybadger-ruby-splitproject', :github =>'ThinkNear/honeybadger-ruby-splitproject'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install honeybadger-ruby-splitproject

## Usage

By default, all errors go to normal Honeybadger account. If no environment key is specified, it will not add any extra methods

### General
1. Add to initializers:
* <code> require 'honeybadger/splitproject' </code>
* <code> Honeybadger::Splitproject.add_notifiers_for_team("[team name]")</code>
2. Add environment variable with key "HONEYBADGER_API_KEY_[TEAM NAME]"
  * "TEAM" must be uppercase with no spaces.
  * e.g. If [team name] = "big team", the environment key name = "HONEYBADGER_API_KEY_BIGTEAM"
  * On Heroku: <code>heroku config:add HONEYBADGER_API_KEY_BIGTEAM="[Honeybadger key]"</code>
3. The following extra methods will be available (for team "big team")
  * <code>Honeybadger.notify_detailed(class_name, error_message, options)</code> - new method for "default Honeybadger account"
  * <code>Honeybadger.notify_bigteam</code> - delegates to Honeybadger.notify with different API key
  * <code>Honeybadger.notify_detailed_bigteam(class_name, error_message, options) </code>
  
### Sidekiq
1. Add alert_team option to sidekiq options, to alert specific team.
  * e.g. sidekiq_options :queue => :main, :alert_team => "rex"

## Contributing

1. Fork it ( https://github.com/[my-github-username]/honeybadger-ruby-splitproject/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
