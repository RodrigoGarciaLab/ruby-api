class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :authorize_request
  # , :cors_preflight_check
  # after_action :cors_set_access_control_headers
  attr_reader :current_user

  # def cors_set_access_control_headers
  #   headers['Access-Control-Allow-Origin'] = '*'
  #   headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
  #   headers['Access-Control-Request-Method'] = '*'
  #   headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  # end

  # def cors_preflight_check
  #   headers['Access-Control-Allow-Origin'] = '*'
  #   headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
  #   headers['Access-Control-Allow-Headers'] = '*'
  #   headers['Access-Control-Request-Method'] = '*'
  #   headers['Access-Control-Max-Age'] = '1728000'
  #   #render :text => '', :content_type => 'text/plain'
  # end

  private

  # Check for valid request token and return user
    def authorize_request
      puts "request --------> #{request}"
      @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
    end

    def authorize_admin_request
      @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
      @current_user.admin?
    end

end