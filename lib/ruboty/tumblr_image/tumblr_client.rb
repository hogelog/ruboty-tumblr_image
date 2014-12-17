require "faraday"
require "faraday_middleware"

module Ruboty
  module TumblrImage
    class TumblrClient
      TUMBLR_PHOTOS_API_URL = "http://api.tumblr.com/v2/blog/%s/posts/photo"

      # open("http://api.tumblr.com/v2/blog/#{TUMBLELOG}/posts/photo?api_key=#{API_KEY}&offset=#{offset}", 'r', &:read)
      #
      attr_reader :options

      def initialize(options)
        @api_key = ENV['RUBOTY_TUMBLR_API_KEY']
        @options = options
      end

      def get
        r = resource
        if r
          photo = r['photos'].sample
          photo['original_size']['url']
        else
          nil
        end
      rescue Exception => exception
        Ruboty.logger.error("Error: #{self}##{__method__} - #{exception}")
        nil
      end

      private

      def resource
        @resource ||= begin
          if posts = response.body["response"] && response.body["response"]["posts"]
            posts.sample
          end
        end
      end

      def response
        connection.get(url, params)
      end

      def url
        TUMBLR_PHOTOS_API_URL % [tumblelog]
      end

      def tumblelog
        user = @options[:username]
        case user
        when /^https?:\/\//
          URI.parse(user).host
        when /\./
          user
        else
          "#{user}.tumblr.com"
        end
      end

      def params
        {
          api_key: ENV['RUBOTY_TUMBLR_API_KEY'],
          limit: '20',
        }
      end

      def connection
        Faraday.new do |connection|
          connection.adapter :net_http
          connection.response :json
        end
      end
    end
  end
end
