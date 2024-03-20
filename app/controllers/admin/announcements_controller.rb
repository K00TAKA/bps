class Admin::AnnouncementsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @announcements = Announcement.all
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.new(announcement_params)
    @admin = current_admin
    @announcement.admin_id = @admin.id

    if @announcement.save
      flash[:notice] = "お知らせの登録に成功しました。"
      redirect_to admin_announcements_path
    else
      flash[:notice] = "お知らせの登録に失敗しました。"
      render :new
    end

  end

  def edit
    @announcement = Announcement.find(params[:id])
  end

  def update
    @announcement = Announcement.find(params[:id])

    if @announcement.update(announcement_params)
      flash[:notice] = "更新に成功しました。"
      redirect_to admin_announcements_path
    else
      flash[:notice] = "更新に成功しました。"
      render :edit
    end
  end

  def destroy
    announcement = Announcement.find(params[:id])
    announcement.destroy
    redirect_to admin_announcements_path
  end

  private

  def announcement_params
    params.require(:announcement).permit(:title, :body, :is_active)
  end

end
