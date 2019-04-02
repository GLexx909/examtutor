class TopicPassagesController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def update
    TopicPassage.find(params[:id]).update(status: true)
  end
end
