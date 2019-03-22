document.addEventListener('turbolinks:load', function() {

    const formButton = $('.profile-edit-form__button');
    if(formButton.length){
        formButton.on('click', showFormFields);
    }
});

function showFormFields() {
    const formFields = $('.profile-edit-form');
    formFields.toggle(400);
}

