class Services::NotificationAdditionalActions

  def initialize(params)
    @params = params
  end

  def action
    case @params[:update_essay_passages]
    when true
      update_essay_passage
    when false
      'Заглушка'
    else
      'Заглушка'
    end
  end

  private

  def update_essay_passage
    essay_passage = EssayPassage.find(@params[:id])
    essay_passage.update(status: true)
  end
end
