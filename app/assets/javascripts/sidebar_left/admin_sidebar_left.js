document.addEventListener('turbolinks:load', function() {

    const sidebarLeft = $('.admin-sidebar-left__small');
    if(sidebarLeft.length){
        sidebarLeft.on('mouseenter', showAdminSidebarFull);
    }

});

function showAdminSidebarFull() {
    const sidebarLeftFull = $('.admin-sidebar-left__full');
    sidebarLeftFull.slideDown(500);

    sidebarLeftFull.on('mouseleave', function () {
        sidebarLeftFull.slideUp(500);
    });
}

