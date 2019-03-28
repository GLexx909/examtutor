document.addEventListener('turbolinks:load', function() {

    const postFormButtonShow = $('.post-form__button-show');
    if (postFormButtonShow.length) {
        postFormButtonShow.on('click', showPostForm);
    }

    const postCardBody = $('.card-text');
    if (postCardBody.length) {
        slicePostBody();
    }

    const postCardHeader = $('.post-card-deck .card-header');
    if (postCardHeader.length) {
        slicePostHeader();
        showFullText();
    }

    const cardDesc = $('.post-card-deck');
    if(cardDesc.length){
        removeImage();
    }
});

// Show/Hide Post Form by Button
function showPostForm() {
    const PostForm = $('.post-form__fields');
    PostForm.toggle(300)
}

// Post-Card show only small part of post-body
function slicePostBody() {
    const size = 160;
    const postBodyDiv = $('.card-text');

    postBodyDiv.each(function(i, elem){
        let text = this.textContent;

        if(text.length > size) {
            this.innerHTML = text.slice(0, size) + ' ...'
        }
    })
}

// Post-Card show only small part of post-header
function slicePostHeader() {
    const size = 200;
    const postHeader = $('.post-card-deck .card-header');

    postHeader.each(function(i, elem){
        let text = this.value;
        if(text.length > size) {
            this.value = text.slice(0, size) + ' ...'
        }
    })
}

// Post-Card-Header text will be displayed inside Post-Card-Body when you mouse over it.
function showFullText() {
    const postHeader = $('.post-card-deck .card-header');

    postHeader.mouseover(function () {
        const id = this.getAttribute('data-id');
        const cardBody = $(".card-text-" + id)[0];
        let cardBodyText = cardBody.textContent;

        cardBody.textContent = this.value;

        $('.card-header-' + id).mouseout(function () {
            cardBody.textContent = cardBodyText;
        })
    });
}

// Remove image tag from Post in card-deck
function removeImage() {
    const image = $('.post-card-deck img');
    image.remove();
}
