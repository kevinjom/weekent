require 'weibo_2'
require 'webrick'
require_relative 'handler/handlers.rb'
require_relative 'handler/handler.rb'
require_relative 'client/weibo.rb'

module Weekent
  class << self
    attr_reader :client

    def bootstrap
      @client = Weekent::Weibo.client
      system %Q{open "#{client.authorize_url}"}
      server = WEBrick::HTTPServer.new :Port => 9999
      server.mount_proc '/weibo/callback' do |req, res|
        code = /code=([^&]+)/.match(req.query_string)[1]
        puts code
        access_token = client.auth_code.get_token code
        refresh_session access_token
        server.shutdown
        repl
      end
      server.start
    end

    private

    def handle_cmd(input)
      return '' if input.nil? || input.empty?
      handler = Weekent::Handlers.handler_for cmd_of input
      handler.handle args_of input
    end

    def cmd_of(input)
      /^\b*(\w+)\b.*/.match(input)[1]
    end

    def args_of(input)
      /^\b*(\w+)\b(.*)/.match(input)[2].chomp
    end

    def repl
      loop do
        print "[#{username}]: "
        puts handle_cmd(gets.chomp)
      end
    end

    def refresh_session(access_token)
      ENV['WEEKENT_TOKEN'] = access_token.token
      ENV['WEEKENT_EXPIRED_AT'] = access_token.expires_at.to_s
      ENV['WEEKENT_UID']=access_token.params["uid"]
    end

    def uid
      ENV['WEEKENT_UID']
    end

    def username
      @username ||= user_profile.name
    end

    def user_profile
      client.users.show_by_uid uid
    end
  end
end
