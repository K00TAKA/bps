class Member::FavoritesController < ApplicationController

  before_action :authenticate_member!

  def create
    @comment = Comment.find(params[:comment_id])
    favorite = current_member.favorites.new(comment_id: @comment.id)
    favorite.save
    # redirect_to request.referer
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    favorite = current_member.favorites.find_by(comment_id: @comment.id)
    favorite.destroy
    # redirect_to request.referer
  end

end
