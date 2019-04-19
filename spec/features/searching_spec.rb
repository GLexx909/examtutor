require 'sphinx_helper'

feature 'User can use Search', %q{
  Every user can use Search panel
  to find users, post.
} do
  given!(:user) { create(:user, first_name: 'test') }
  given!(:post) { create(:post, author: user, title: 'test') }

  background do
    sign_in(user)
  end

  %w(Пользователь Пост).each do |klass|
    scenario "Try to find #{klass}", js: true do
      ThinkingSphinx::Test.run do
        visit root_path

        within('.search-block') do
          select klass, from: 'category'
          fill_in 'search', with: 'test'
          click_on 'Найти'
        end
        expect(current_path).to eq searches_path
        expect(page).to have_content('test')
      end
    end
  end

  scenario "Try to find with Везде", js: true do
    ThinkingSphinx::Test.run do
      # sign_in(user)
      visit root_path

      within('.search-block') do
        select 'Везде', from: 'category'
        fill_in 'search', with: 'test'
        click_on 'Найти'
      end

      expect(current_path).to eq searches_path
      expect(page).to have_content('test')
    end
  end

  scenario "Try to find with blank query", js: true do
    ThinkingSphinx::Test.run do
      # sign_in(user)
      visit root_path

      within('.search-block') do
        select 'Везде', from: 'category'
        fill_in 'search', with: ''
        click_on 'Найти'
      end

      expect(page).to have_content('Поле не может быть пустым')
    end
  end
end
