require "omniauth"
require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class ProductHunt < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPES = %w[public private].freeze

      option :name, "producthunt"

      option :client_options,
             site: "https://api.producthunt.com",
             authorize_url: "/v1/oauth/authorize",
             token_url: "/v1/oauth/token"

      def callback_url
        options[:redirect_uri] || full_host + script_name + callback_path
      end

      def authorize_params
        super.tap do |params|
          scope = params[:scope].to_s.split(/\s+/)
          scope = scope.concat(DEFAULT_SCOPES.reject {|s| scope.include?(s) })
          params[:scope] = scope.join(" ")
        end
      end

      uid do
        raw_info[:user][:id]
      end

      info do
        identity = raw_info[:user]

        {
          name: identity[:name],
          nickname: identity[:username],
          email: identity[:email],
          description: identity[:headline],
          image: identity[:image_url][:"100px"],
          urls: {
            site: identity[:website_url],
            profile: identity[:profile_url]
          }
        }
      end

      def raw_info
        @raw_info ||= deep_symbolize(access_token.get("/v1/me").parsed)
      end
    end

    Producthunt = ProductHunt
  end
end
