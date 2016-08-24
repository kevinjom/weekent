module Weekent
  class Weibo
    class << self
      def client
        @client ||= new_client
      end

      private

      def new_client
        config_app
        WeiboOAuth2::Client.new
      end

      def config_app
        WeiboOAuth2::Config.api_key = ENV.fetch 'API_KEY'
        WeiboOAuth2::Config.api_secret = ENV.fetch 'API_SEC'
        WeiboOAuth2::Config.redirect_uri = 'http://127.0.0.1:9999/weibo/callback'
      end
    end
  end
end
