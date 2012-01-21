class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if resource.role == 'dj'
      dj = resource.create_dj!
      edit_dj_path(dj)
    elsif resource.role == 'singer'
      singer = resource.create_singer!
      edit_singer_path(singer)
    end
  end

end 
