class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :mobilize
  before_filter :check_su

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

    def check_su
      if params[:su] == 'false'
        session[:su] = nil
      elsif params[:su] and can? :switch, User 
        session[:su] = true
      end
    end

    def current_role
      if user_signed_in?
        current_user.role
      else
        :guest
      end
    end
    helper_method :current_role

    def current_dj
        current_user.dj if current_role == 'dj'
    end
    helper_method :current_dj

    def current_singer
        current_user.singer if current_role == 'singer'
    end
    helper_method :current_singer

end
