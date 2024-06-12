# frozen_string_literal: true

class Member::RoomsController < ApplicationController
  before_action :authenticate_member!

  def create
    @room = Room.create
    Entry.create(room_id: @room.id, member_id: current_member.id)
    Entry.create(params.require(:entry).permit(:member_id, :room_id).merge(room_id: @room.id))
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(member_id: current_member.id, room_id: @room.id).present?
      @messages = @room.messages.order(created_at: :desc)
      @message = Message.new
      @entries = @room.entries
    end
  end
end
