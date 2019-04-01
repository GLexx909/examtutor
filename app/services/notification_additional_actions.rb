class Services::NotificationAdditionalActions

  def initialize(params)
    @params = params
  end

  def action
    case @params[:additional_data]
    when 'update_essay_passage_status'
      update_essay_passage
    else
      ''
    end
  end

  private

  def update_essay_passage
    essay_passage = EssayPassage.find(@params[:id])
    essay_passage.update(status: true)
  end
end
