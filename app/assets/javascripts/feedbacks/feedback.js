$(document).on('turbolinks:load', function(){

    const feedbackButton = $('.feedback__show-form__button');
    if(feedbackButton) {
        feedbackButton.on('click', function () {
            const feedbackFormNew = $('.feedback__form-new');
            feedbackFormNew.slideToggle(500)
        })
    }
});
