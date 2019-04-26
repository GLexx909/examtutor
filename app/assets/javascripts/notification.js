$(document).on('turbolinks:load', function() {

    // Notification Cable, send notification to particular person.

    const userId = $('.user-icon').data('userId');
    if (userId) {
        App.cable.subscriptions.create({channel: 'NotificationsChannel', id: userId}, {
            connected: function () {
                return this.perform('follow');
            },

            received: function (data) {
                const dropdownDiv = $('.nav__right-block .dropdown-menu__notifications');
                const dropdownButton = $('.nav__right-block .notify-button');
                dropdownButton.html('<i class="material-icons md-18 stub red">notifications_active</i>');
                dropdownDiv.prepend(JST["templates/notification_essay_to_tutor"]({notification: data['notification'], link: data['link']}));
            }
        });
    }

    const notificationButtonReady = $('.notification-button__read-already');
    if (notificationButtonReady) {
        notificationButtonReady.on('click', function () {

            $('.notifications-list a').removeClass('badge-warning').addClass('badge-light');
        })
    }
});
