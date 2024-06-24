# frozen_string_literal: true

class Member::MessagesController < ApplicationController
  before_action :authenticate_member!
  before_action :set_room, only: [:create, :destroy]

  def create
    if Entry.where(member_id: current_member.id, room_id: @room.id).present?
      @message = Message.new(message_params)
      if @message.save
        flash[:notice] = "送信しました。"
      else
        Rails.logger.error(@message.errors.full_messages.join(', '))
        flash[:notice] = "送信に失敗しました。"
      end
    end
    redirect_to room_path(@room.id)
  end

  def destroy
    message = Message.find(params[:message][:id])
    message.destroy
    redirect_to room_path(@room.id)
  end

  private
    def set_room
      @room = Room.find(params[:message][:room_id])
    end

    def message_params
      params.require(:message).permit(:member_id, :body, :room_id).merge(member_id: current_member.id)
    end
end
