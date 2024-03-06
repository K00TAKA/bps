class Admin::MembersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @member = Member.new
    @members = Member.all
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      flash[:notice] = "会員ステータスを更新しました"
      redirect_to admin_members_path
    else
      flash[:notice] = "会員ステータスの更新に失敗しました"
      render :index
    end
  end

  private

  def member_params
    params.permit(:member_status)
  end

end