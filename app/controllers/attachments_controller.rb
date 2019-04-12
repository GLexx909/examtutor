class AttachmentsController < ApplicationController

  def destroy
    @file = ActiveStorage::Attachment.find(params[:id])
    authorize! :manage, @file

    if current_user.author_of?(@file.record)
      @file.purge
    else
      return head 403
    end

    head :ok
  end
end
