document.addEventListener('turbolinks:load', function() {

    const flashBlock = $('.flash-block .alert');

    if (flashBlock.length) {
        hideFlashBlock();
    }
});

function hideFlashBlock() {
    const flashBlock = $('.flash-block .alert');

    setTimeout(() => {
        flashBlock.fadeOut(4000)
    }, 7000);
}
