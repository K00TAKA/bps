# frozen_string_literal: true

class Member::MessagesController < ApplicationController
  before_action :authenticate_member!

  def create
    if Entry.where(member_id: current_member.id, room_id: params[:message][:room_id]).present?
      @message = Message.new(message_params)
      @room = @message.room
      if @message.save
        @roommembernotme = Entry.where(room_id: @room.id).where.not(member_id: current_member.id)
        @theid = @roommembernotme.find_by(room_id: @room.id)
        notification = current_member.active_notifications.new(
          room_id: @room.id,
          message_id: @message.id,
          visited_id: @theid.member_id,
          visitor_id: current_member.id,
          action: 'message'
        )
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
        flash[:notice] = "送信しました。"
        @room = Room.find(params[:message][:room_id])
        redirect_to room_path(@room.id)
      else
        flash[:notice] = "送信に失敗しました。"
        @room = Room.find(params[:message][:room_id])
        redirect_to room_path(@room.id)
      end
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
