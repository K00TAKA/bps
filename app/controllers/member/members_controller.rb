class Member::MembersController < ApplicationController

  before_action :authenticate_member!

  def show
    @member = Member.find(params[:id])
    # @company = Company.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find([:id])
    if @member.update(member_params)
      flash[:notice] = "会員情報更新に成功しました"
      redirect_to edit_member_path(params[:id])
    else
      flash[:notice] = "会員情報更新に失敗しました"
      render :edit
    end
  end

  private

  def member_params
  params.require(:member).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email)
  end

end
