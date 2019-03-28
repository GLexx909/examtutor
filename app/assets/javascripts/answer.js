$(document).on('turbolinks:load', function(){
    $('form.answer-for-question').on('ajax:success', function(e) {
        var id = e.detail[0]['id'];
        var user_answer = e.detail[0]['user_answer'];
        var real_answer = e.detail[0]['real_answer'];

        $('.question-' + id + ' .user_answer').html('<p>' + 'Ваш ответ: ' + user_answer + '</p>' + '<p>' + 'Правильный ответ: ' + real_answer + '</p>');
        $('.question-' + id + ' input').val('');

        if(user_answer === real_answer){
            $('.question-' + id + ' .sign_correct').show();
        } else {
            $('.question-' + id + ' .sign_wrong').show();
        }
    })
});
