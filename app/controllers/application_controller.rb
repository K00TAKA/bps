# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protected
    def member_sign_up?
      !current_member.has_company?
    end

    def after_member_sign_up_path_for(resource)
      if member_sign_up?
        new_company_path
      else
        root_path
      end
    end

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
