class Api::BaseController  < ApplicationController
  protect_from_forgery with: :null_session

  respond_to :json, :xml

  protected

    def doorkeeper_unauthorized_render_options
      {
        json: {
          status: "401",
          message: "The application is not authorized",
          developerMessage: "The application have to be authorized for '#{request.original_url}'.",
          links: {
            moreInfo: "http://developers.lvh.me:3000/docs/felkoder",
            documentation: "http://developers.lvh.me:3000/docs/kom-igang",
            self: request.original_url
          }
        }
      }
    end

    def from_id name
      found = name.camelize.constantize.find_by_uuid(params[:id])

      if found
        instance_variable_set "@#{name.camelize(:lower)}", found
      else
        render 'api/errors/404', status: 404
      end
    end

    def render_error
      begin
        yield
      rescue ActiveRecord::RecordInvalid => e
        @errors = e.record.errors
        render 'api/errors/400', status: 400
      rescue
        render 'api/errors/500', status: 500
      end
    end

    def method_missing method, *args, &block
      return from_id(method.to_s.match(/^find_(.*)$/)[1]) if method.to_s =~ /^find_(.*)$/
      super
    end

    def restrict_access_with_token
      authenticate_or_request_with_http_token do |token, options|
        Doorkeeper::Application.exists? uid: token
      end
    end

    def current_resource_owner_user
      if doorkeeper_token
        @current_resource_owner_user ||= User.find(doorkeeper_token.resource_owner_id)
      end
    end
end
