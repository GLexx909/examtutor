require 'rails_helper'

RSpec.describe Message, type: :model do
  it { should belong_to(:abonent) }
  it { should belong_to(:author) }

  it { should validate_presence_of :body }

  let!(:user)  { create :user, first_name: 'Mahmud'}
  let!(:user2) { create :user, first_name: 'Ivan' }
  let!(:user3) { create :user, first_name: 'Lena' }
  let!(:message1) { create :message, author: user, abonent: user2 }
  let!(:message2) { create :message, author: user2, abonent: user }
  let!(:message3) { create :message, author: user2, abonent: user3 }
  let!(:message4) { create :message, author: user3, abonent: user }

  it_behaves_like 'Have many attached file', let(:object_class){ Message }

  describe 'Message.own(current_user)' do
    it 'return messages where user take part' do
      arr = [message4, message2, message1]
      expect(Message.own(user)).to eq arr
    end
  end

  describe 'Message.penpals(current_user)' do
    it 'return users of messages except current_user' do
      other_users = User.all - [user]
      expect(Message.penpals(user).sort).to eq other_users.sort
    end
  end
end
