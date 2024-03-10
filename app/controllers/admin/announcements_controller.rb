class Admin::AnnouncementsController < ApplicationController

  before_action :authenticate_admin!

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.new(announcement_params)
    @admin = current_admin
    @announcement.admin_id = @admin.id

    if params[:draft].present?
      @announcement.status = :draft
    else
      @announcement.status = :published
    end

    if @announcement.save
      if @announcement.draft?
        redirect_to dashboard_posts_path, notice: '下書きが保存されました。'
      else
        redirect_to admin_announcements_path, notice: '投稿が公開されました。'
      end
    else
      render :new
    end
  end

  def edit
    @announcement = Announcement.find(params[:id])
    @admin = current_admin
  end

  def update
    @admin = current_admin
    @announcement = Announcement.find(params[:id])

    @announcement.assign_attributes(announcement_params)

    if params[:draft].present?
      @announcement.status = :draft
      notice_message = "下書きを保存しました。"
      redirect_path = dashboard_posts_path
    elsif params[:unpublished].present?
      @announcement.status = :unpublished
      notice_message = "非公開にしました。"
      redirect_path = dashboard_posts_path
    else
      @announcemenmt.status = :published
      notice_message = "投稿を更新しました。"
      redirect_path = post_path(@post)
    end

    if @announcement.save
      redirect_to redirect_path, notice: notice_message
    else
      render :edit
    end
  end

  private

  def announcement_params
    params.require(:announcement).permit(:body, :status)
  end

end
