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
        klass = case ENV['RUBOTY_TUMBLR_CLIENT'] || 'google'
        when 'google'
          Ruboty::TumblrImage::GoogleClient   
        when 'tumblr'
          Ruboty::TumblrImage::TumblrClient   
        when 'google+tumblr', 'hybrid'
          Ruboty::TumblrImage::HybridClient
        else
          if ENV['RUBOTY_TUMBLR_API_KEY']
            Ruboty::TumblrImage::HybridClient
          else
            Ruboty::TumblrImage::GoogleClient
          end
        end

        klass.new(username: username, unsafe: unsafe).get
      end
    end
  end
end
