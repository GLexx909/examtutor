document.addEventListener('turbolinks:load', function() {

    const postFormButtonShow = $('.post-form__button-show');

    if (postFormButtonShow.length) {
        postFormButtonShow.on('click', showPostForm);
    }

    const postCardBody = $('.card-text');

    if (postCardBody.length) {
        slicePostBody();
    }
});

// Show/Hide Post Form by Button
function showPostForm() {
    const PostForm = $('.post-form__fields');
    PostForm.toggle(300)
}

// Post-Card show only small part of post-body
function slicePostBody() {
    const size = 120;
    const postBodyDiv = $('.card-text');

    postBodyDiv.each(function(i, elem){
        let text = this.textContent;

        if(text.length > size) {
            this.innerHTML = text.slice(0, size) + ' ...'
        }
    })
}

