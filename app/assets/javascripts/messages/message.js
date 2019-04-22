document.addEventListener('turbolinks:load', function() {

    const modalNewMessageButtonSuccess = $('.modal__new-message__button-success');

    if (modalNewMessageButtonSuccess.length) {
        modalNewMessageButtonSuccess.on('click', hideModalNewMessageForm);
    }

    // Action Cable publish new message or delete message
    const userId1 = $('.correspondence-block').data('idOne');
    const userId2 = $('.correspondence-block').data('idTwo');
    if (userId1) {
        App.cable.subscriptions.create({channel: 'MessagesChannel', id_one: userId1, id_two: userId2}, {
            connected: function () {
                return this.perform('follow');
            },

            received: function (data) {
                if (data['action'] === 'create') {
                    const messagesList = $('.messages-list');
                    console.log(data['files']);
                    messagesList.append(JST["templates/message"]({ message: data['message'], is_admin: data['is_admin?'], files: data['files']}));
                    scrollToElement();
                } else if (data['action'] === 'delete') {
                    const messageId = data['message_id'];
                    $('.message-' + messageId).slideToggle(500);
                }
            }
        });
    }

    scrollToElement()
});

function hideModalNewMessageForm() {
    const newMessageModal   = $('#newMessageModal');
    newMessageModal.modal('hide');
    setTimeout('tinyMCEClear()', 'fast');
}


function scrollToElement() {
    const messagesBlock = $('.messages-block');
    const length = $('.each-message').length;

    messagesBlock.animate({scrollTop: messagesBlock.height()*length },"fast");
    return false;
}

function tinyMCEClear() {
    setTimeout('tinyMCE.activeEditor.setContent(\'\')', 'fast');
}
