document.addEventListener('turbolinks:load', function() {

    const modalNewMessageButtonSuccess = $('.modal__new-message__button-success');

    if (modalNewMessageButtonSuccess.length) {
        modalNewMessageButtonSuccess.on('click', hideModalNewMessageForm);
    }

    // Action Cable publish new message
    const userId1 = $('.correspondence-block').data('idOne');
    const userId2 = $('.correspondence-block').data('idTwo');
    if (userId1) {
        App.cable.subscriptions.create({channel: 'MessagesChannel', id_one: userId1, id_two: userId2}, {
            connected: function () {
                return this.perform('follow');
            },

            received: function (data) {
                const messagesList = $('.messages-list');
                messagesList.append(JST["templates/message"]({ message: data['message'] }));
                scrollToElement();
            }
        });
    }

    // Scroll to bottom of message list
    const correspondenceBlock = $('.correspondence-block');
    const newMessageSendButton = $('.new-message-send__button');
    if (correspondenceBlock.length) {
        function delay(ms) {
            return new Promise((resolve) => {
                setTimeout(() => {
                    resolve();
                }, ms)
            });
        }

        const promise = delay(1000);
        promise.then(() => scrollToElement());
        promise.then(() => newMessageSendButton.on('click', scrollToElementAndCreatForm));
    }
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

function scrollToElementAndCreatForm() {
    scrollToElement();
    tinyMCEClear();
}
function tinyMCEClear() {
    setTimeout('tinyMCE.activeEditor.setContent(\'\')', 'fast');
}
