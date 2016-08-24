module Weekent
  module Handler
    class None
      def self.handle(*input)
        'invalid command, type h for help'
      end
    end

    class Quit
      Weekent::Handlers.register 'quit', self, 'quit weekent'
      def self.handle(*input)
        puts 'goodbye'
        sleep 1
        exit
      end
    end

    class Help
      Weekent::Handlers.register 'help', self, 'show commands'
      def self.handle(*input)
        Weekent::Handlers.handlers.map do |cmd, handler|
          "#{cmd} - #{handler[:desc]}"
        end.join("\n")
      end
    end

    class Post
      Weekent::Handlers.register 'post', self, 'post a weibo'
      def self.handle(input)
        Weekent::Weibo.client.statuses.update input
      end
    end

    class List
      Weekent::Handlers.register 'list', self, 'list messages you have posted'
      def self.handle(*input)
       Weekent::Weibo.client.statuses.user_timeline.statuses.map do |status|
         status.text
       end.join("\n")
      end
    end
  end
end
