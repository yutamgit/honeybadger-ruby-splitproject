class KeyHelpers
  class << self
    
    def env_key(team_name)
      "HONEYBADGER_API_KEY_#{team_name.delete(' ').upcase}"
    end
  end
end