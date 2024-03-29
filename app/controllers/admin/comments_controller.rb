class Admin::CommentsController < ApplicationController

  before_action :authenticate_admin!

  def show
    @company = Company.find(params[:id]).page(params[:page]).per(5)
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = "ステータス更新に成功しました"
      redirect_to admin_comment_path(@comment.company_id)
    else
      flash[:notice] = "ステータス更新に失敗しました"
      render :show
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:is_active)
  end

end
