document.addEventListener('turbolinks:load', function() {

    const postFormButtonShow = $('.post-form__button-show');

    if (postFormButtonShow.length) {
        postFormButtonShow.on('click', showPostForm);
    }
});

function showPostForm() {
    const PostForm = $('.post-form__fields');
    PostForm.toggle(300)
}
