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
    # [処理内容1]　入力されたemailからアカウント1件取得
    member = Member.find_by(email: params[:member][:email])
    # [処理内容2]　アカウントを取得できなかった場合、このメソッドを終了する
    return if member.nil?
    # [処理内容3]　取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了する
    return unless member.valid_password?(params[:member][:password])
    # 【処理内容4】 アクティブでない会員に対する処理
    member.update(is_active: false)
    # 今回、会員情報を削除せず、is_activeを使ってステータス管理する（trueは入会中、falseは退会済み）
  end

  protected

  def after_sign_in_path_for(resource)
    root_path
  end

  # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
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
