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
end
