# frozen_string_literal: true

class Member::CommentsController < ApplicationController
  before_action :authenticate_member!

  def index
    @company = current_member.company
    @comments = @company.comments.where(is_active: true).page(params[:page]).per(10)
  end

  def new
    @company = Company.find(params[:company_id]) if params[:company_id].present?
    @comment = Comment.new
  end

  def create
    @comment = current_member.comments.new(comment_params)
    if @comment.save
      flash[:notice] = "コメント投稿に成功しました。"
      redirect_to company_path(@comment.company_id)
    else
      flash[:notice] = "コメント投稿に失敗しました。"
      @company = Company.find(params[:comment][:company_id])
      @comments = @company.comments.where(is_active: true).page(params[:page]).per(10)
      render :new
    end
  end

  def comment_params
    params.require(:comment).permit(:comment, :company_id)
  end
end
