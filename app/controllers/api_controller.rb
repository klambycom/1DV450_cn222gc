class ApiController  < ActionController::Base
  protect_from_forgery with: :null_session
  before_filter :restrict_access

  protected

    def from_id name
      begin
        instance_variable_set "@#{name.camelize(:lower)}",
                              name.camelize.constantize.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render nothing: true, status: 404
      end
    end

    def render_error
      begin
        yield
      rescue ActiveRecord::RecordInvalid => e
        render json: e.record.errors, status: 422
      rescue
        render nothing: true, status: 500
      end
    end

    def method_missing method, *args, &block
      return from_id(method.to_s.match(/^find_(.*)$/)[1]) if method.to_s =~ /^find_(.*)$/
      super
    end

  private
  
    def request_http_token_authentication(realm = "Application")  
      headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
      render :json => {
               :error => "HTTP Token: Access denied. You did not provide an valid API key." 
             }.to_json,
             :status => :unauthorized
    end

    def restrict_access
      authenticate_or_request_with_http_token do |token, options|
        App.exists? access_token: token
      end
    end
end
