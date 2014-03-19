require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class ToerhDoorkeeper < OmniAuth::Strategies::OAuth2
      option :name, :toerh_doorkeeper

      option :client_options, {
        site: 'http://api.lvh.me:3000',
        authorize_url: '/oauth/authorize'
      }

      uid { raw_info['uuid'] }

      info do
        {
          name: "#{raw_info['firstname']} #{raw_info['lastname']}",
          email: raw_info['email'],
          first_name: raw_info['firstname'],
          last_name: raw_info['lastname']
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/users').parsed
      end
    end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :toerh_doorkeeper, "98540e836d1cb2ea0c0a6e2258bcbd3efec7fc22ef7c7d8b31745d192706fe3c", "5d66848f57b977d76272b79193eece090687515095201e285635e49e4efa3245"
end
