require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :password }

  it { should have_many(:posts).dependent(:destroy) }
  it { should have_many(:courses).through(:course_passages) }
  it { should have_many(:course_passages).dependent(:destroy) }
  it { should have_many(:moduls).through(:modul_passages) }
  it { should have_many(:modul_passages).dependent(:destroy) }
  it { should have_many(:topics).through(:topic_passages) }
  it { should have_many(:topic_passages).dependent(:destroy) }
  it { should have_many(:essays).through(:essay_passages) }
  it { should have_many(:essay_passages).dependent(:destroy) }
  it { should have_many(:tests).through(:test_passages) }
  it { should have_many(:test_passages).dependent(:destroy) }
  it { should have_many(:questions).through(:question_passages) }
  it { should have_many(:question_passages).dependent(:destroy) }
  it { should have_many(:notifications).dependent(:destroy) }
  it { should have_many(:messages).dependent(:destroy) }
  it { should have_many(:abonents).through(:messages) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:attendances).dependent(:destroy) }
  it { should have_one(:characteristic).dependent(:destroy) }
  it { should have_many(:progresses).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should have_one(:feedback) }

  let!(:user)       { create :user }
  let!(:user_other) { create :user }
  let!(:admin) { create :user, admin: true }
  let!(:post)       { create :post, author: user }
  let!(:course) { create :course }
  let!(:course_passage) { create :course_passage, user: user, course: course }
  let!(:message1) { create :message, author: user, abonent: user_other }
  let!(:message2) { create :message, author: user_other, abonent: user }
  let!(:notification1) { create :notification, author: user_other, abonent: user, type_of: 'message' }
  let!(:notification2) { create :notification, author: user_other, abonent: user, type_of: 'message' }

  describe 'User#author_of? check' do
    it 'is user the author of entry' do
      expect(user).to be_author_of(post)
    end

    it 'is user not author of entry' do
      expect(user_other).to_not be_author_of(post)
    end
  end

  describe 'User.author_or_admin_of? check' do
    it 'is user the author of resource' do
      expect(user).to be_author_or_admin_of(post)
    end

    it 'is user not author of resource' do
      expect(user_other).to_not be_author_or_admin_of(post)
    end
  end

  describe 'User#not_admin check' do
    it 'return all user not admin' do
      users = User.not_admin

      users.each do |user|
        expect(user.admin).to be_falsey
      end
    end
  end

  describe 'User.full_name check' do
    it 'return full user name' do
      expect(user.full_name).to eq 'John Doe'
    end
  end

  describe 'User#have_course?(course) check' do
    it 'return course passage' do
      expect(user.have_course?(course)).to eq course_passage
    end
  end

  describe 'user#messages_with_self(abonent)' do
    it 'return messages where user take part' do
      expect(user.messages_with(user_other)).to eq [message1, message2]
    end
  end

  describe 'user#notifications_from_penpals(abonent)' do
    it 'return notifications where user is abonent of other person' do
      expect(user.notifications_from_penpals(user_other)).to eq [notification1, notification2]
    end
  end

  describe 'user#uniq_notifications' do
    it 'return notifications where user is abonent of other person in single copy' do
      expect(user.uniq_notifications_of_message).to eq [notification2]
    end
  end

  describe '.find_for_oauth' do
    let!(:auth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123456') }
    let!(:email) { 'email@example.com' }
    let(:service) { double('Services::FindForOauth') }

    it 'calls Services::FindForOauth' do
      expect(Services::FindForOauth).to receive(:new).with(auth, email).and_return(service)
      expect(service).to receive(:call)
      User.find_for_oauth(auth, email)
    end
  end
end
