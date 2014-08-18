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
<code> Honeybadger::Splitproject.add_notifiers_for_team("[team name]")</code>
2. Add environment variable with key "HONEYBADGER_API_KEY_[TEAM NAME]"
  * "TEAM" must be uppercase with no spaces.
  * e.g. If [team name] = "big team", the environment key name = "HONEYBADGER_API_KEY_BIGTEAM"
3. The following methods will be available
  * Honeybadger.notify_detailed(class_name, error_message, options)
  * Honeybadger.notify_[team name], where team name is lowercase with no spaces (e.g. Honeybadger.notify_bigteam)
  * Honeybadger.notify_detailed_[team_name](class_name, error_message, options) (e.g. Honeybadger.notify_detailed_bigteam)
  
### Sidekiq
1. Add alert_team option to sidekiq options, to alert specific team.
  * e.g. sidekiq_options :queue => :main, :alert_team => "rex"

## Contributing

1. Fork it ( https://github.com/[my-github-username]/honeybadger-ruby-splitproject/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
