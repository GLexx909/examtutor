require 'rails_helper'

feature 'User can vote for a post', %q{
  In order to improve the rating of a post
  As an authorized user
  I'd like to be able to vote
}do
  given!(:user) { create :user}
  given!(:user2) { create :user}
  given!(:post) { create :post, author: user}

  describe 'Not author vote for a post' do
    before do
      sign_in(user2)
      visit post_path(post)
    end

    scenario 'vote up', js: true do
      within(".post-votes") do
        find('.vote-up').click
        expect(page).to have_content '1'
      end
    end

    scenario 'vote down', js: true do
      within(".post-votes") do
        find('.vote-down').click
        expect(page).to have_content '-1'
      end
    end

    scenario 'vote up twice', js: true do
      within(".post-votes") do
        find('.vote-up').click
        find('.vote-up').click
        expect(page).to have_content '1'
      end
    end

    scenario 'vote down twice', js: true do
      within(".post-votes") do
        find('.vote-down').click
        find('.vote-down').click

        expect(page).to have_content '-1'
      end
    end

    scenario 'and cancel up-vote', js: true do
      within(".post-votes") do
        find('.vote-up').click
        find('.vote-down').click

        expect(page).to have_content '0'
      end
    end

    scenario 'and cancel down-vote', js: true do
      within(".post-votes") do
        find('.vote-down').click
        find('.vote-up').click

        expect(page).to have_content '0'
      end
    end
  end

  describe 'Author tries to vote for a post, but can not' do
    before do
      sign_in(user)
      visit post_path(post)
    end

    scenario 'vote up', js: true do
      within(".post-votes") do
        expect(page).to_not have_css 'vote-up'
      end
    end

    scenario 'vote down', js: true do
      within(".post-votes") do
        expect(page).to_not have_css 'vote-down'
      end
    end
  end
end
