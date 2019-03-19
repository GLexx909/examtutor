document.addEventListener('turbolinks:load', function() {

    const stubElement = $('.stub');
    if(stubElement.length){
        preventDefault();
    }
});

function preventDefault() {
    $('.stub').click(function(e){
        e.preventDefault();
    })
}

