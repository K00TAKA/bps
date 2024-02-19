class Admin::CommentsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @comments = Comment.all
  end

  def update
    @comment = Company.find([:id])
    if @comment.update(comment_params)
      flash[:notice] = "ステータス更新に成功しました"
      redirect_to _________
    else
      flash[:notice] = "ステータス更新に失敗しました"
      render :________
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:is_active)
  end

end
