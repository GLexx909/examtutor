$(document).on('turbolinks:load', function(){

    const tableTests = $('.table-tests');
    if (tableTests.length) {
        tableTests.on('mouseenter', showAlert);
        tableTests.on('mouseleave', hideAlert);
    }

});

function showAlert() {
    const alertMessage = $('.alert-danger');
    alertMessage.show(500);
}

function hideAlert() {
    const alertMessage = $('.alert-danger');
    alertMessage.hide(500);
}
