class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :mobilize

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to request.referer ? :back : main_app.root_path, \
                                  :alert => exception.message
  end

  private

    def mobilize
      prepend_view_path Rails.root+'app/views/mobile' if mobile?
    end

    def mobile?
      true
    end
    helper_method :mobile?
end
