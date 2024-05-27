# frozen_string_literal: true

class Member::FavoritesController < ApplicationController
  before_action :authenticate_member!

  def create
    @comment = Comment.find(params[:comment_id])
    favorite = current_member.favorites.new(comment_id: @comment.id)
    favorite.save
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    favorite = current_member.favorites.find_by(comment_id: @comment.id)
    favorite.destroy
  end
end
