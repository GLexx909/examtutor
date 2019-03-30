class TestPassagesController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def update
    test_passage.update(status: true)
    redirect_to modul_path(modul)
  end

  private

  def test_passage
    @test_passage ||= TestPassage.find(params[:id])
  end

  def modul
    test_passage.test.modul
  end
end
