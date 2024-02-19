class Member::CommentsController < ApplicationController

  before_action :authenticate_member!

  def create
    @comment = Comment.new(comment_params)
    if comment.save
      flash[:notice] = "コメントの登録に成功しました。"
      redirect_to __________path
    else
      flash[:notice] = "コメントの登録に失敗しました。"
      render :__________
    end
  end

end
