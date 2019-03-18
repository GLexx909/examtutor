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
    { post: { title: '', body: '' } }
  end
end
