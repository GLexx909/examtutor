document.addEventListener('turbolinks:load', function() {

    const modalFooterRegistrationButton = $('.modal-footer__registration-button');

    if (modalFooterRegistrationButton.length) {
        modalFooterRegistrationButton.on('click', showModalRegistrationForm);
    }
});

function showModalRegistrationForm() {
    const modalFooterRegistrationForm   = $('.modal-footer__registration-form');
    modalFooterRegistrationForm.slideToggle(300)
}
