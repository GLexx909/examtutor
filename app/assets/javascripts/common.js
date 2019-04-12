document.addEventListener('turbolinks:load', function() {

    const stubElement = $('.stub');
    if(stubElement.length){
        preventDefault();
    }

    const confirmButton = $('.confirm');
    if(confirmButton.length){
        confirmButton.on('click', confirmDelete);
    }
});

function preventDefault() {
    $('.stub').click(function(e){
        e.preventDefault();
    })
}

function confirmDelete() {
    return confirm('Вы уверены?');
}
