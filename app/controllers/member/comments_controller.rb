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
    @company = Company.find(params[:company_id])
    if @comment.save
      flash[:notice] = "コメントの登録に成功しました。"
      redirect_to company_path(params[:id])
    else
      flash[:notice] = "コメントの登録に失敗しました。"
      render :index
    end
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
