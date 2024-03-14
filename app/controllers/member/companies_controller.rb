class Member::CompaniesController < ApplicationController

  before_action :authenticate_member!

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    @company.member_id = current_member.id
    @company.date_of_establishment = "設立年月日を入れてください"
    @company.introduction = "紹介文を入れてください"
    @genre = "業種を登録してください"
    if @company.save
      flash[:notice] = "企業の登録に成功しました。"
      redirect_to company_path(@company.id)
    else
      flash[:notice] = "企業の登録に失敗しました。"
      render :new
    end
  end

  def index
    # @company = Company.find(params[:id])
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
    @comment = Comment.new
    @comments = @company.comments.where(is_active: true)
    @member = @company.member # 会員情報を取得する
    @currentmemberEntry = Entry.where(member_id: current_member.id)
    @memberEntry = Entry.where(member_id: @member.id)
    if @member.id == current_member.id
      @msg = "他の企業の担当者とDMしてみよう！"
    else
      @currentmemberEntry.each do |cu|
        @memberEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end

      if @isRoom != true
        @room = Room.new
        @entry = Entry.new
      end
    end
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
