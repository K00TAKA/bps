class ApplicationController < ActionController::Base

  before_action :search

  def search
    #検索機能
    @q = Company.ransack(params[:q])
    @company = @q.result(distinct: true)
    @result = params[:q]&.values&.reject(&:blank?)
  end


  protected

  def after_sign_in_path_for(resource)
    if member_signed_in?
      root_path
    elsif admin_signed_in?
      root_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
      admin_session_path
    else
      root_path
    end
  end

end
