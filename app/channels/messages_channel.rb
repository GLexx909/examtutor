class MessagesChannel < ApplicationCable::Channel
  def follow
    stream_from "correspondence_of_#{params[:id_one]}_and_#{params[:id_two]}"
  end
end
