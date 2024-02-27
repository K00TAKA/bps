class Admin::CompaniesController < ApplicationController

  before_action :authenticate_admin!

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find([:id])
    if @company.update(company_params)
      flash[:notice] = "ステータス更新に成功しました"
      redirect_to admin_company_path
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
