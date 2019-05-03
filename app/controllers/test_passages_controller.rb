class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :test_passage, only: [:show]
  before_action :test, only: [:show]

  authorize_resource

  def show
  end

  def update_status
    test_passage.update(status: true)
    timer_check
    Services::SendNotificationService.new("На проверку тест от #{current_user.full_name}", test_passage_path(test_passage), admin, current_user).send
    Services::CharacteristicChangeService.new(current_user, requests, test_passage.points, profile_path(current_user), test: test_passage.test).change
    create_next_modul_passage
    head :ok
  end

  private

  def test_passage
    @test_passage ||= TestPassage.find(params[:id])
  end

  def test
    @test = test_passage.test
  end

  def modul
    test_passage.test.modul
  end

  def requests
    request.referrer.split('/')[3]
  end

  def timer_check
    test_passage.update(points: 0) if (test.timer*60 - ((test_passage.updated_at - test_passage.created_at)/60).round) <= 5
  end

  def create_next_modul_passage
    # Update next modul status to true if previous modul was over
    if modul.over?(current_user)
      next_modul = modul.course.moduls.where("position > #{modul.position}").first
      next_modul&.modul_passage(@current_user)&.update(status: true)
    end
  end
end
