class Member::CommentsController < ApplicationController

  before_action :authenticate_member!

  def new
    @comment = Comment.new
  end

  def index
    @comments = Comment.all
  end

  def create
    @member = current_member
    @comment = Comment.new(comment_params)
    @comment.member_id = current_member_id
    if comment.save
      flash[:notice] = "コメントの登録に成功しました。"
      redirect_to company_path
    else
      flash[:notice] = "コメントの登録に失敗しました。"
      render :index
    end
  end

end
