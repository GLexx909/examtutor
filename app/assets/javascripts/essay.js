$(document).on('turbolinks:load', function(){

    const editButton = $('.essay-edit__button button');
    if (editButton.length) {
        editButton.on('click', showEssayForm);
    }

    const sendButton = $('.send-essay__button');
    if (sendButton.length) {
        sendButton.on('click', sendEssayButton);
    }

    const checkButton = $('.check-essay__button');
    if (checkButton.length) {
        checkButton.on('click', checkEssayButton);
    }
});

function showEssayForm() {
    const editForm = $('.essay_passages__form_edit');
    const essayBody = $('.essay-passage__body');
    editForm.toggle(500);
    essayBody.toggle(500);
}

function sendEssayButton() {
    const sendButton = $('.send-essay__button');
    const flashBlock = $('.flash-block');
    sendButton.hide(500);
    flashBlock.html('Уведомление отправлено репетитору!')
}

function checkEssayButton() {
    const checkButton = $('.check-essay__button');
    const flashBlock = $('.flash-block');
    checkButton.hide(500);
    flashBlock.html('Уведомление отправлено ученику!')
}
