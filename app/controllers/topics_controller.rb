class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :topic, only: [:new, :show, :edit]

  authorize_resource

  def new
  end

  def show
  end

  def create
    @topic = modul.topics.create(topic_params)
  end

  def edit
  end

  def update
    topic.update(topic_params)
  end

  def destroy
    topic.destroy
    redirect_to topic.modul
  end

  private

  def modul
    @modul ||= Modul.find(params[:modul_id])
  end

  def topic
    @topic ||= params[:id] ? Topic.find(params[:id]) : modul.topics.new
  end

  def topic_params
    params.require(:topic).permit(:title, :body)
  end
end
