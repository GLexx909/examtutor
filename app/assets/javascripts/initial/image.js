document.addEventListener('turbolinks:load', function() {

    // To disable right click on mouse to all images in this block
    const tutorInfoBlock = $('.tutor-info__block');
    if (tutorInfoBlock) {
        const img = $('.tutor-info__block img');
        img.contextmenu(function () {
            return false
        })
    }
});
