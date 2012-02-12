class PagesController < ApplicationController
  def index
    if user_signed_in?
      if current_user.dj?
        render :dj
      end
    end
  end

  def dj
    @dj = current_user.dj
  end

  def singer
    @singer = current_user.singer
  end

end
