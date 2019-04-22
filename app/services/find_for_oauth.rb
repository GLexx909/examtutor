class Services::FindForOauth
  attr_reader :auth

  def initialize(auth, email)
    @auth = auth
    @email = email
  end

  def call
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    email = @email || auth.info[:email]

    if auth[:provider] == 'facebook'
      full_name = auth.info[:name]
      @first_name = full_name.split(' ').first
      @last_name = full_name.split(' ').last
    elsif auth[:provider] == 'github'
      full_name = auth.info[:name]
      @first_name = full_name&.split(' ')&.first || auth.info[:nickname]
      @last_name = full_name&.split(' ')&.last || auth.info[:nickname]
    end

    image = auth.info[:image]

    user = User.where(email: email).first

    if user
      user.create_authorization(auth)
    else
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password, first_name: @first_name, last_name: @last_name, oauth_image: image)
      user.create_authorization(auth)
    end
    user
  end
end
