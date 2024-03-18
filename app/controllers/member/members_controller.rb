class Member::MembersController < ApplicationController

  before_action :authenticate_member!

  def show
    @member = Member.find(params[:id])
    @company = current_member.company
  end

  def edit
    @member = Member.find(params[:id])
    @company = current_member.company
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      flash[:notice] = "会員情報更新に成功しました"
      redirect_to member_path(params[:id])
    else
      flash[:notice] = "会員情報更新に失敗しました"
      render :edit
    end
  end

  def withdraw
    @member = Member.find(current_member.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @member.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def member_params
  params.require(:member).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email)
  end

end
