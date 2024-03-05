class Member::CompaniesController < ApplicationController

  before_action :authenticate_member!

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    @company.member_id = current_member.id
    if @company.save
      flash[:notice] = "企業の登録に成功しました。"
      redirect_to company_path(params[:id])
    else
      flash[:notice] = "企業の登録に失敗しました。"
      render :new
    end
  end

  def index
    @companies = Company.all
  end

  def show
    # @company = Company.find(params[:id])
    @comments = Comment.all
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find([:id])
    if @company.update(company_params)
      flash[:notice] = "ステータス更新に成功しました"
      redirect_to company_path(params[:id])
    else
      flash[:notice] = "ステータス更新に失敗しました"
      render :edit
    end
  end

  def destroy
    member = current_member.find(params[:id])
    member.destroy
    redirect_to root_path
  end

  private

  def company_params
  params.require(:company).permit(:image, :company, :company_kana, :genre_id, :establish, :introduction, :post_code, :address, :tel, :email)
  end

end
