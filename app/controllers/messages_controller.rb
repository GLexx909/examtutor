class MessagesController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def abonents
    @abonents = Message.penpals(current_user)
  end
end
