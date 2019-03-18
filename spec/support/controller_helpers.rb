module ControllerHelpers
  def login(user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in(user)
  end

  def post_params
    { post: attributes_for(:post) }
  end

  def one_time_password_params
    { one_time_password: attributes_for(:one_time_password) }
  end
  #
  # def question_params_new
  #   { question: { title: 'new_title', body: 'new_body' } }
  # end
  #
  # def question_params_invalid
  #   { question: attributes_for(:question, :invalid) }
  # end
  #
  # def answer_params
  #   { question_id: question, answer: attributes_for(:answer) }
  # end
  #
  # def answer_params_new
  #   { answer: { body: 'new_body' } }
  # end
  #
  # def answer_params_invalid
  #   { question_id: question, answer: attributes_for(:answer, :invalid) }
  # end
end
