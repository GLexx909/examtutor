require 'rails_helper'

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should_not be_able_to :manage, :all }
    it { should_not be_able_to :tutor_index, Post }
    it { should_not be_able_to :read, Post }
  end

  describe 'for admin' do
    let(:user) { create :user, admin: true }

    it { should be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user)        { create :user }
    let(:user_other)  { create :user }
    let(:post)        { create :post, author: user }
    let(:post_other)  { create :post, author: user_other}

    it { should_not be_able_to :manage, :all }

    it { should be_able_to :read, Post }
    it { should be_able_to :tutor_index, Post }
    it { should be_able_to :own_index, Post }

    it { should be_able_to :update, post }
    it { should_not be_able_to :update, post_other }

    it { should be_able_to :destroy, post }
    it { should_not be_able_to :destroy, post_other }
  end
end
