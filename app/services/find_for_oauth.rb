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
      @image = auth.info[:image]
    elsif auth[:provider] == 'github'
      full_name = auth.info[:name]
      @first_name = full_name&.split(' ')&.first || auth.info[:nickname]
      @last_name = full_name&.split(' ')&.last || auth.info[:nickname]
      @image = auth.info[:image]
    elsif auth[:provider] == 'vkontakte'
      @first_name = auth.extra.raw_info[:first_name]
      @last_name = auth.extra.raw_info[:last_name]
      @image = auth.extra.raw_info[:photo_200_orig]
    end

    user = User.find_by(email: email)

    if user&.first_name == 'temporary'
      user.update(first_name: @first_name, last_name: @last_name, oauth_image: @image)
      user.create_authorization(auth)
    else
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password, first_name: @first_name, last_name: @last_name, oauth_image: @image)
      user.create_authorization(auth)
    end
    user
  end
end
