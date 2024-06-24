# frozen_string_literal: true

class Member::CompaniesController < ApplicationController
  before_action :authenticate_member!
  before_action :check_company_active, except: [:index, :new, :create]

  def new
    @company = Company.new
  end

  def create
    @company = current_member.build_company(company_params)
    @member = current_member
    @company.date_of_establishment = "〇年〇月"
    @company.introduction = "紹介文"
    if @company.save
      flash[:notice] = "企業の登録に成功しました。"
      redirect_to member_path(@member.id)
    else
      render :new
    end
  end

  def index
    @companies = Company.all.page(params[:page]).per(10)
    if current_member.company.nil?
    redirect_to new_company_path
    flash[:notice] = "企業情報がまだ登録されていません。このまま登録を行ってしてください。"
    end
  end

  def show
    @company = Company.find(params[:id])
    @comments = @company.comments.where(is_active: true)
    @member = @company.member
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
    @member = current_member
  end

  def update
    @company = Company.find(params[:id])
    @member = current_member
    if @company.update!(company_params)
      redirect_to member_path(@member.id)
    else
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
      params.require(:company).permit(:image, :company, :company_kana, :genre, :post_code, :address, :date_of_establishment, :introduction, :tel, :email, :member_id)
    end

    def check_company_active
      @company = Company.find(params[:id])
      unless @company.is_active
        redirect_to root_path
        flash[:notice] = "お探しの企業は解約済みです。"
      end
    end
end
