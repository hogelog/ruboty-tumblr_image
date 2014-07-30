module Ruboty
  module Handlers
    class TumblrImage < Base
      on /tumblr (?<unsafe>unsafe )?(?<username>.+)/, name: "tumblr", description: "Pickup image from Tumblr"

      def tumblr(message)
        url = search(message[:username], !!message[:unsafe])
        message.reply(url.to_s)
      end

      private

      def search(username, unsafe)
        Ruboty::TumblrImage::Client.new(username: username, unsafe: unsafe).get
      end
    end
  end
end
