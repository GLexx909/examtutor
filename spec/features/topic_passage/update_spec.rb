require 'rails_helper'

feature 'User can finish topic passing', %q{
} do

  given!(:admin) {create(:user, admin: true) }
  given!(:user) {create(:user) }
  given!(:admin) {create(:user, admin: true) }
  given!(:course) {create(:course) }
  given!(:modul) {create(:modul, course: course) }
  given!(:topic) {create(:topic, modul: modul) }
  given!(:topic_passage) {create(:topic_passage, topic: topic, user: user) }

  describe 'User' do
    background do
      sign_in(user)
      visit topic_path(topic)
    end

    scenario 'finish a topic passing', js: true do
      click_on 'Материал прочитан'

      expect(page).to have_content 'Баллы получены!'

      topic_passage.reload
      expect(topic_passage.status).to be_truthy
    end
  end
end

