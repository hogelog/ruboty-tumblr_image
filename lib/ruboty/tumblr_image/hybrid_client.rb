module Ruboty
  module TumblrImage
    class HybridClient
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def get
        if @options[:unsafe] && ENV['RUBOTY_TUMBLR_API_KEY']
          Ruboty::TumblrImage::TumblrClient.new(@options).get
        else
          Ruboty::TumblrImage::GoogleClient.new(@options).get
        end
      rescue Exception => exception
        Ruboty.logger.error("Error: #{self}##{__method__} - #{exception}")
        nil
      end
    end
  end
end
