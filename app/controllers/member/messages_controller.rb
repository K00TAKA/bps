class Member::MessagesController < ApplicationController

  before_action :authenticate_member!

  def create
    if Entry.where(member_id: current_member.id, room_id: params[:message][:room_id]).present?
      @message = Message.new(message_params)
      if @message.save
        redirect_to "/rooms/#{@room.id}"
      end
    else
      redirect_to "/rooms/#{@room.id}"
    end
  end

  private
    def message_params
      params.require(:message).permit(:member_id, :body, :room_id).merge(member_id: current_member.id)
    end
end
