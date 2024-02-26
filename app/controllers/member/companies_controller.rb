class Member::CompaniesController < ApplicationController

  before_action :authenticate_member!

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:notice] = "企業の登録に成功しました。"
      redirect_to __________
    else
      flash[:notice] = "企業の登録に失敗しました。"
      render :__________
    end
  end

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
    @comments = Comment.all
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find([:id])
    if @company.update(company_params)
      flash[:notice] = "ステータス更新に成功しました"
      redirect_to _________path
    else
      flash[:notice] = "ステータス更新に失敗しました"
      render :________
    end
  end

  def destroy
    member = current_member.find(params[:id])
    member.destroy
    redirect_to __________path
  end

  private

  def company_params
  params.require(:company).permit(:company, :company_kana, :genre_id, :establish, :introduction, :post_code, :address, :telephone, :email)
  end

end
