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
    #@comment.company_id = current_member.company_id
    # ↑は以下のコメントアウトを一つにまとめたもの
    # @member = current_member
    # @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = "コメントの登録に成功しました。"
      redirect_to company_path(@comment.company_id)
    else
      flash[:notice] = "コメントの登録に失敗しました。"
      render :index
    end
  end

  def comment_params
    params.require(:comment).permit(:comment, :company_id)
  end

end
