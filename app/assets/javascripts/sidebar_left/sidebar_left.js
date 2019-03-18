document.addEventListener('turbolinks:load', function() {

    const sidebarLeft = $('.sidebar-left__small');
    if(sidebarLeft.length){
        sidebarLeft.on('mouseenter', showSidebarFull);
    }

});

function showSidebarFull() {
    const sidebarLeftFull = $('.sidebar-left__full');
    sidebarLeftFull.slideDown(500);

    sidebarLeftFull.on('mouseleave', function () {
        sidebarLeftFull.slideUp(500);
    });
}

