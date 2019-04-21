document.addEventListener('turbolinks:load', function() {

    const modalFooterRegistrationButton = $('.modal-footer__registration-button');

    if (modalFooterRegistrationButton.length) {
        modalFooterRegistrationButton.on('click', showModalRegistrationForm);
    }

    const historyButton = $('.history-button');
    $(historyButton).on('click', function(e){
        e.preventDefault();
        $('html,body').stop().animate({ scrollTop: $('.history-block').offset().top }, 1000);
    });

    const socialButton = $('.social-button');
    $(socialButton).on('click', function(e){
        e.preventDefault();
        $('html,body').stop().animate({ scrollTop: $('.social-block').offset().top }, 1000);
    });

    const russianButton = $('.russian-button');
    $(russianButton).on('click', function(e){
        e.preventDefault();
        $('html,body').stop().animate({ scrollTop: $('.russian-block').offset().top }, 1000);
    });

    const englishButton = $('.english-button');
    $(englishButton).on('click', function(e){
        e.preventDefault();
        $('html,body').stop().animate({ scrollTop: $('.english-block').offset().top }, 1000);
    });
});

function showModalRegistrationForm() {
    const modalFooterRegistrationForm   = $('.modal-footer__registration-form');
    modalFooterRegistrationForm.slideToggle(300)
}
