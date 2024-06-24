# frozen_string_literal: true

class Member::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :check_member_active, except: [:edit, :update]

  def show
    @member = Member.find(params[:id])
    @company = current_member.company
    if @company.nil?
    redirect_to new_company_path
    flash[:notice] = "企業情報がまだ登録されていません。このまま登録を行ってしてください。"
    end
  end

  def edit
    is_matching_login_member
    @member = Member.find(params[:id])
    @company = current_member.company
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to member_path(params[:id])
    else
      render :edit
    end
  end

  def withdraw
    @member = Member.find(current_member.id)
    @member.update(is_active: false)
    @member.company.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  def destroy
    @member = Member.find(params[:id])
    @company = @member.company
    if @member.destroy
      @company.destroy if @company
      redirect_to root_path
    else
      render :edit
    end
  end

  private
    def is_matching_login_member
      member = Member.find(params[:id])
      unless member.id == current_member.id
        redirect_to member_path(current_member.id)
      end
    end

    def member_params
      params.require(:member).permit(:name, :name_kana, :email)
    end

    def is_active_changed_to_false?
      saved_change_to_attribute?(:is_active) && !is_active
    end

    def deactivate_company
      company.update(is_active: false) if company
    end

    def check_member_active
      @member = Member.find(params[:id])
      unless @member.is_active
        redirect_to root_path
        flash[:notice] = "お探しの会員は退会済みです。"
      end
    end
end
