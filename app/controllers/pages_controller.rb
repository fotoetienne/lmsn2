class PagesController < ApplicationController
  def index
    if current_dj
      if current_dj.songs.empty?
        flash.now[:info] = "Welcome! This page lets you manage your DJ account from a PC or mobile device. Visit the songlist manager and add some songs to get started!"
      end
      render 'dj_home'
    elsif current_singer
      render 'singer_home'
    end
  end

  def dj
    @dj = current_user.dj
  end

  def singer
    @singer = current_user.singer
  end

end
