class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :topic, only: [:new, :show, :edit]

  skip_before_action :verify_authenticity_token, only: [:sort]

  authorize_resource

  add_breadcrumb "Курсы".html_safe, :courses_path

  def new
  end

  def show
    bread_crumbs
    create_topic_passage
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

  def sort
    params[:topic].each_with_index do |id, index|
      Topic.find(id).update(position: index+1)
    end

    head :ok
  end

  private

  def modul
    @modul ||= Modul.find(params[:modul_id])
  end

  def topic
    @topic ||= params[:id] ? Topic.find(params[:id]) : modul.topics.new
  end

  def bread_crumbs
    add_breadcrumb "Модули", course_path(topic.modul.course)
    add_breadcrumb "Модуль #{topic.modul.title}", modul_path(topic.modul)
  end

  def create_topic_passage
    topic.topic_passages.create(user: current_user) unless topic.topic_passage(current_user)
  end

  def topic_params
    params.require(:topic).permit(:title, :body)
  end
end
