class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    if request.referer
      redirect_to :back, :alert => exception.message
    else
      redirect_to main_app.root_path, :alert => exception.message
    end
  end
end
