class ApplicationController < ActionController::Base

  protected

  def after_sign_in_path_for(resource)
    if member_signed_in?
      __________path
    elsif admin_signed_in?
      __________path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
      __________path
    else
      root_path
    end
  end

end
