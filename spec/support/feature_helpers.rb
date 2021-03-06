module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Почта', with: user.email
    fill_in 'Пароль', with: user.password
    click_on 'Войти'
  end

  def sign_out
    click_on 'Sign out'
  end

  def tinymce_fill_in(id, val)
    # id must be the id attribute of the editor instance (without the #) e.g.
    #     <textarea id="foo" ...></textarea>
    # would be filled in by calling
    #     tinymce_fill_in 'foo', 'some stuff'
    # wait until the TinyMCE editor instance is ready. This is required for cases
    # where the editor is loaded via XHR.
    sleep 0.5 until page.evaluate_script("tinyMCE.get('#{id}') !== null")

    js = "tinyMCE.get('#{id}').setContent('#{val}')"
    page.execute_script(js)
  end
end
