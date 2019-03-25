module ControllerHelpers
  def login(user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in(user)
  end

  def post_params
    { post: attributes_for(:post) }
  end

  def post_params_new
    { post: { title: 'new_title', body: 'new_body' } }
  end

  def one_time_password_params
    { one_time_password: attributes_for(:one_time_password) }
  end

  def post_params_invalid
    { post: attributes_for(:post, :invalid) }
  end

  def user_params
    { user: attributes_for(:user) }
  end

  def user_params_invalid
    { user: attributes_for(:user, :invalid) }
  end

  def user_params_new
    { user: { first_name: 'new_first_name', last_name: 'new_last_name' } }
  end

  def course_params
    { course: attributes_for(:course) }
  end

  def course_params_invalid
    { course: attributes_for(:course, :invalid) }
  end

  def course_params_new
    { course: { title: 'new_title' } }
  end

  def modul_params(course)
    { modul: attributes_for(:modul), course_id: course }
  end

  def modul_params_invalid(course)
    { modul: attributes_for(:modul, :invalid), course_id: course }
  end

  def modul_params_new(course)
    { modul: { title: 'new_title' }, course_id: course }
  end

  def topic_params(modul)
    { topic: attributes_for(:topic), modul_id: modul }
  end

  def topic_params_invalid(modul)
    { topic: attributes_for(:topic, :invalid), modul_id: modul }
  end

  def topic_params_new(modul)
    { topic: { title: 'new_title', body: 'new_body' }, modul_id: modul }
  end

  def essay_params(modul)
    { essay: attributes_for(:essay), modul_id: modul }
  end

  def essay_params_invalid(modul)
    { essay: attributes_for(:essay, :invalid), modul_id: modul }
  end

  def essay_params_new(modul)
    { essay: { title: 'new_title' }, modul_id: modul }
  end

  def test_params(modul)
    { test: attributes_for(:test), modul_id: modul }
  end

  def test_params_invalid(modul)
    { test: attributes_for(:test, :invalid), modul_id: modul }
  end

  def test_params_new(modul)
    { test: { title: 'new_title' }, modul_id: modul }
  end

  def question_params(test)
    { question: attributes_for(:question), test_id: test }
  end

  def question_params_invalid(test)
    { question: attributes_for(:question, :invalid), test_id: test }
  end

  def question_params_new(test)
    { question: { title: 'new_title' }, test_id: test }
  end

  def answer_params(question)
    { answer: attributes_for(:answer), question_id: question }
  end

  def answer_params_invalid(question)
    { answer: attributes_for(:answer, :invalid), question_id: question }
  end

  def answer_params_new(question)
    { answer: { body: 'new_body' }, question_id: question }
  end
end
