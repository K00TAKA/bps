class Member::RoomsController < ApplicationController

  before_action :authenticate_member!

  def create
    @room = Room.create
    Entry.create(room_id: @room.id, member_id: current_member.id)
    Entry.create(params.require(:entry).permit(:member_id, :room_id).merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(member_id: current_member.id, room_id: @room.id).present?
      @messages = @room.messages.all
      @message = Message.new
      @entries = @room.entries
    else
      redirect_to  room_path(@room.id)
    end
  end
end
