require 'rails_helper'

RSpec.describe Services::FindForOauth do
  let!(:auth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123456') }
  let!(:user1) { create :user }
  let(:email) { nil }
  subject { Services::FindForOauth.new(auth, email) }

  context 'user already has authorization' do
    it 'returns the user' do
      user1.authorizations.create(provider: 'github', uid: '123456')
      expect(subject.call).to eq user1
    end
  end

  context 'user has not authorization' do
    context 'user already exists' do
      let!(:user1) { create :user, first_name: 'temporary', last_name: 'temporary' }
      let!(:auth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123456', info: { email: user1.email, name: 'John Doe' }) }

      it 'does not create new user' do
        expect{subject.call}.to_not change(User, :count)
      end

      it 'creates authorization for user' do
        expect{subject.call}.to change(user1.authorizations, :count).by(1)
      end

      it 'creates authorization with provider and uid' do
        authorization = subject.call.authorizations.first
        expect(authorization.provider).to eq auth.provider
        expect(authorization.uid).to eq auth.uid
      end

      it 'returns the user' do
        expect(subject.call).to eq user1
      end
    end
  end

  context 'user does not exist' do
    let!(:auth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123456', info: { email: 'new@user.com', name: 'John Doe' }) }

    it 'create new user' do
      expect{ subject.call }.to change(User, :count).by(1)
    end

    it 'returns new user' do
      expect( subject.call).to be_a(User)
    end

    it 'fills user email' do
      user = subject.call
      expect(user.email).to eq auth.info[:email]
    end

    it 'create authorization for user' do
      user = subject.call
      expect(user.authorizations).to_not be_empty
    end

    it 'creates authorization with provider and uid' do
      authorization = subject.call.authorizations.first

      expect(authorization.provider).to eq auth.provider
      expect(authorization.uid).to eq auth.uid
    end
  end
end
