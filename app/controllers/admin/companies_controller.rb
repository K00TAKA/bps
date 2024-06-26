# frozen_string_literal: true

class Admin::CompaniesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @companies = Company.all.page(params[:page]).per(10)
  end

  def show
    if @company.nil?
      redirect_to admin_member_path
      flash[:notice] = "企業情報がまだ登録されていません。"
    else
      @company = Company.find(params[:id])
    end
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
      flash[:notice] = "ステータス更新に成功しました"
      redirect_to admin_company_path(@company.id)
    else
      flash[:notice] = "ステータス更新に失敗しました"
      render :show
    end
  end

  private
    def company_params
      params.require(:company).permit(:is_active)
    end
end
