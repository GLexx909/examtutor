$(document).on('turbolinks:load', function() {

    // Notification Cable, send notification to particular person.

    const userId = $('.user-icon').data('userId');
    if (userId) {
        App.cable.subscriptions.create({channel: 'NotificationsChannel', id: userId}, {
            connected: function () {
                return this.perform('follow');
            },

            received: function (data) {
                const dropdownDiv = $('.nav__right-block .dropdown-menu');
                const dropdownButton = $('.nav__right-block .notify-button');
                dropdownButton.html('<i class="material-icons md-18 stub red">notifications_active</i>');
                dropdownDiv.append(JST["templates/notification_essay_to_tutor"]({notification: data['notification']}));
            }
        });
    }
});
