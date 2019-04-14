$(document).on('turbolinks:load', function(){

    const testTime = $('.test-time');
    if (testTime.length) {
        startTimer()
    }

});

function startTimer() {
    const testTime = $('.test-time');
    const button = $('.send-essay__button');
    let time = testTime.text();

    if (time <= 0) {
        button.click();
    }

    const interval = setInterval( timer, 60000);

    function timer() {
        time --;

        $('.test-time').text(time);

        if (time <= 0) {
            stopTest();
            button.click();
        }
    }

    function stopTest() {
        clearInterval(interval);
    }
}
