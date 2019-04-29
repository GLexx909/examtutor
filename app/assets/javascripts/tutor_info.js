document.addEventListener('turbolinks:load', function() {
    const tutorInfoButton = $('.form_tutor_info__button');
    if (tutorInfoButton.length) {
        tutorInfoButton.on('click', showTutorInfoForm);
    }

    const tutorInfoDeleteButton = $('.tutor-info-diplom__delete-button');
    if (tutorInfoDeleteButton.length) {
        tutorInfoDeleteButton.on('click', function () {
            const id = $(this).data('id');
            $('.diplom-' + id).hide(300);
        });
    }
});

//Show Hide form
function showTutorInfoForm() {
    const tutorInfoForm = $('.form_tutor_info__fields');
    tutorInfoForm.toggle(600)
}

