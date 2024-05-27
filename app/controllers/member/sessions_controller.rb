# frozen_string_literal: true

class Member::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :member_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  private
    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
    end

    def member_state
      member = Member.find_by(email: params[:member][:email])
      return if member.nil?
      return unless member.valid_password?(params[:member][:password])
      member.update(is_active: true)
    end

  protected
    def after_sign_in_path_for(resource)
      root_path
    end

    def reject_member
      @member = Member.find_by(name: params[:member][:name])
      if @member
        if @member.valid_password?(params[:member][:password]) && (@member.is_active == false)
          flash[:notice] = "退会済みです。再度ご登録の上、ご利用ください。"
          redirect_to new_member_registration
        else
          flash[:notice] = "項目を入力してください"
        end
      end
    end
end
