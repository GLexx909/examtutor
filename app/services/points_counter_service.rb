class Services::PointsCounterService

  def initialize(question_passage, current_user)
    @question_passage = question_passage
    @current_user = current_user
  end

  def check_answer
    @true_answer = @question_passage.question.answer
    @true_answer_body = @true_answer.body
    @user_answer_body = @question_passage.answer
    @points = @true_answer.points
    @errors = 0

    @question_passage.question.answer.is_number? ? number_checking : word_checking

    current_points = @question_passage.question.points(@current_user)
    @question_passage.question.test_passage(@current_user).update(points: current_points + @points)
    @question_passage.update(points: @points)

    @points == @true_answer.points # Is the answer completely correct?
  end

  private

  def number_checking
    @length = @true_answer_body.length - 1
    extra_numbers = @user_answer_body.length - @true_answer_body.length
    extra_errors = extra_numbers > 0 ? extra_numbers : 0 # Лишние ответы

    @true_answer.full_accordance? ? full_accordance : not_full_accordance # Если ответ должен быть последовательным

    @points -= @errors
    @points -= extra_errors
    @points = 0 if @points < 0
  end

  def full_accordance
    (0..@length).each do |number|
      @errors += 1 if @user_answer_body[number] != @true_answer_body[number]
    end
  end

  def not_full_accordance
    @user_answer_body.split('').each do |number|
      @errors += 1 unless @true_answer_body.include?(number)
    end

    lacking_numbers = @true_answer_body.length - @user_answer_body.length
    @errors += lacking_numbers
  end

  def word_checking
    user_answer = @user_answer_body
    true_answers_array= @true_answer_body.split(' ')
    @points = 0 unless true_answers_array.include?(user_answer)
  end
end
