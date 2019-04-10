require 'rails_helper'

feature 'User can update comment', %q{
} do

    given!(:user) {create(:user) }
    given!(:post) {create(:post, author: user) }
    given!(:comment) {create(:comment, author: user, post: post, body: "CommentBody") }

    describe 'Admin' do
        background do
            sign_in(user)
            visit post_path(post)
        end

        scenario 'update the comment', js: true do
            within '.comments-list' do
                click_on 'Редактировать'

                fill_in 'comment[body]', with: 'CommentBodyNew'
                click_on 'Сохранить комментарий'

                expect(page).to have_content 'CommentBodyNew'
            end
        end

        scenario 'update the comment with error', js: true do
            within '.comments-list' do
                click_on 'Редактировать'

                fill_in 'comment[body]', with: ''
                click_on 'Сохранить комментарий'

                expect(page).to have_content 'CommentBody'
            end

            expect(page).to have_content 'Комментарий не может быть пустым'
        end
    end

    scenario 'Unauthenticated user can not update a comment' do
        visit post_path(post)
        expect(page).to_not have_button('Редактировать')
    end
end
