document.addEventListener('turbolinks:load', function() {

    const modalNewMessageButtonSuccess = $('.modal__new-message__button-success');

    if (modalNewMessageButtonSuccess.length) {
        modalNewMessageButtonSuccess.on('click', hideModalNewMessageForm);
    }
});

function hideModalNewMessageForm() {
    const newMessageModal   = $('#newMessageModal');
    newMessageModal.modal('hide');
    setTimeout('tinyMCEClear()', 2000);
}

function tinyMCEClear() {
    tinyMCE.activeEditor.setContent('');
}
