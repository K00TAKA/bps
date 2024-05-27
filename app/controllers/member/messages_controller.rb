# frozen_string_literal: true

class Member::MessagesController < ApplicationController
  before_action :authenticate_member!

  def create
    if Entry.where(member_id: current_member.id, room_id: params[:message][:room_id]).present?
      @message = Message.new(message_params)
      if @message.save
        flash[:notice] = "送信しました。"
        @room = Room.find(params[:message][:room_id])
        redirect_to room_path(@room.id)
      end
    else
      flash[:notice] = "送信に失敗しました。"
      @room = Room.find(params[:message][:room_id])
      redirect_to room_path(@room.id)
    end
  end

  def destroy
    message = Message.find(params[:message][:id])
    message.destroy
    @room = Room.find(params[:message][:room_id])
    redirect_to room_path(@room.id)
  end

  private
    def message_params
      params.require(:message).permit(:member_id, :body, :room_id).merge(member_id: current_member.id)
    end
end
