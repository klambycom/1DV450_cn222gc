class ApiController  < ActionController::Base
  protect_from_forgery with: :null_session

  protected

    def from_id name
      begin
        instance_variable_set "@#{name}", name.camelize.constantize.find(params[:id])
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
end