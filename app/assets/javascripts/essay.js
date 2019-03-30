$(document).on('turbolinks:load', function(){

    const editButton = $('.essay-edit__button');
    if (editButton.length) {
        editButton.on('click', showEssayForm);
    }

});

function showEssayForm() {
    const editForm = $('.essay_passages__form_edit');
    const essayBody = $('.essay-passage__body');
    editForm.toggle(500);
    essayBody.toggle(500);
}
