require 'honeybadger/honeybadger'
require 'honeybadger/key_helpers'

module Honeybadger
  module Splitproject
    
    class << self
      def add_notifiers_for_team(team_postfix)
        raise "Blank team given for Honeybadger." if team_postfix.nil? || team_postfix.strip.length == 0
        
        env_key = KeyHelpers.env_key(team_postfix)
        api_key = ENV[env_key]
        
        raise "Team #{team_postfix} already setup with honeybadger" if Honeybadger.respond_to?("notify_#{team_postfix}")
        
        team_postfix = team_postfix.delete(' ').downcase
        
        add_team_specific_notifier(team_postfix, api_key)
        add_team_specific_detailed_notifier(team_postfix)
      end
      
      private
      # this will add a notify_<teamname> method.
      def add_team_specific_notifier(team_postfix, api_key)
        if api_key.nil? || api_key.length == 0
          Honeybadger.instance_eval do
            define_singleton_method("notify_#{team_postfix}") do |exception, options = {}|
              notify(exception, options)
            end
          end
        else
          Honeybadger.instance_eval do
            define_singleton_method("notify_#{team_postfix}") do |exception, options = {}|
              notify(exception, options.merge({ api_key: api_key }))
            end
          end
        end
      end
    
      # this will add a notify_detailed_<teamname> method.
      def add_team_specific_detailed_notifier(team_postfix)
        Honeybadger.instance_eval do
          define_singleton_method("notify_detailed_#{team_postfix}") do |error_class, error_message, parameters = {}|
            options = parameters.merge({ error_message: error_message })
            send("notify_#{team_postfix}", { error_class: error_class }, options)
          end
        end
      end
      
    end
  end
end
