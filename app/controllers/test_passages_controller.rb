class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :test_passage, only: [:show]
  before_action :test, only: [:show]

  authorize_resource

  def show
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
end
