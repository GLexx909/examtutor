require 'rails_helper'

feature 'Admin only can edit topic', %q{
} do

  given!(:user) { create(:user) }
  given!(:admin) { create(:user, admin: true) }
  given!(:course) { create :course }
  given!(:modul) { create :modul, course: course  }
  given!(:topic) { create :topic, modul: modul, title: 'Topic'  }

  describe "Unauthenticated user" do
    scenario 'can not edit topic' do
      visit topic_path(topic)

      expect(page).to_not have_link 'Редактировать'
    end
  end

  describe 'Authenticated user' do
    scenario 'can not edit topic', js: true do
      sign_in user
      visit topic_path(topic)

      expect(page).to_not have_button 'Редактировать'
    end
  end

  scenario 'Admin can edit topic', js: true do
    sign_in admin
    visit topic_path(topic)

    click_on 'Редактировать'

    fill_in 'topic[title]', with: 'Topic Title New'
    click_on 'Сохранить изменения'

    expect(page).to have_content 'Topic Title New'
    expect(page).to_not have_content 'TopicTitle'
  end
end
