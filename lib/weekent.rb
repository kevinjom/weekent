require 'weibo_2'

class Weekent
  class << self
    def bootstrap
      config_app
      client = WeiboOAuth2::Client.new
      # TODO:
    end

    def config_app
      WeiboOAuth2::Config.api_key = ENV.fetch 'API_KEY'
      WeiboOAuth2::Config.api_secret = ENV.fetch 'APP_SEC'
      WeiboOAuth2::Config.redirect_uri = 'http://kevinjom.github.io/weibo/callback'
    end
  end
end
