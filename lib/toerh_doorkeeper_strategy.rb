#require 'omniauth/core'

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
          email: raw_info['email']
          first_name: raw_info['firstname'],
          last_name: raw_info['lastname']
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/users').parsed
      end
    end

    #class ToerhDoorkeeper
    #  include OmniAuth::Strategy

    #  def initialize(app, secret, auth_redirect, options = {})
    #    @secret = secret
    #    @auth_redirect = auth_redirect
    #    super(app, :toerh, options)
    #  end

    #  def request_phase
    #    r = Rack::Response.new
    #    r.redirect @auth_redirect
    #    r.finish
    #  end

    #  def callback_phase
    #    uuid, username, avatar, token = request.params["uid"], request.params["username"], request.params["username"], , request.params["avatar"], request.params["token"]
    #    sha1 = Digest::SHA1.hexdigest("a mix of #{@secret}, #{uid}, #{username}, #{avatar}")

    #    if sha1 == token
    #      @uid, @username, @avatar = uid, username, avatar
    #      super
    #    else
    #      fail!(:invalid_credentials)
    #    end
    #  end

    #  def auth_hash
    #    OmniAuth::Utils.deep_merge(super(), {
    #      'uid' => @uid,
    #      'user_info' => {
    #        'name'     => @username,
    #        'nickname' => @username,
    #        'image'    => @avatar
    #      }
    #    })
    #  end
    #end
  end
end
