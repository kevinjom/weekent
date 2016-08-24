module Weekent
  class Handlers
    class <<self
      def handler_for(cmd)
        handlers[cmd] ? handlers[cmd][:handler]  : Weekent::Handler::None
      end

      def register(cmd, handler, desc='')
         handlers[cmd] = {handler: handler, desc: desc}
      end

      def handlers
        @handlers ||= {}
      end
    end
  end
end
