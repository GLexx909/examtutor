class Services::NotificationAdditionalActions

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def action
    case @params[:notification][:additional_data]
    when 'update_essay_passage_status'
      update_essay_passage
    when 'update_test_passage_status'
      update_test_passage
    else
      ''
    end
  end

  private

  def update_essay_passage
    essay_passage = EssayPassage.find(@params[:notification][:id])
    essay_passage.update(status: true)
  end

  def update_test_passage
    test_passage = TestPassage.find(@params[:notification][:id])
    test_passage.update(status: true)
    create_next_modul_passage(test_passage)
  end

  def create_next_modul_passage(test_passage)
    # Update next modul status to true if last test of previous modul was over
    modul = test_passage.test.modul

    if modul.over?(@current_user)
      next_modul = modul.course.moduls.where("id > #{modul.id}").first
      next_modul&.modul_passage(@current_user)&.update(status: true)
    end
  end
end
