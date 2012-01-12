class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @user = User.find(params[:id])
  end

  def account
    @user = User.find(params[:id])
    if current_user.role == 'dj'
      redirect_to dj_edit_path(current_user.account) and return false
    end 
  end
end
