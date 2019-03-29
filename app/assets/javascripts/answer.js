$(document).on('turbolinks:load', function(){

    // Answer response

    $('form.answer-for-question_form').on('ajax:success', function(e) {
        var id = e.detail[0]['id'];
        var user_answer = e.detail[0]['user_answer'];
        var real_answer = e.detail[0]['real_answer'];
        var result = e.detail[0]['result'];
        var points = e.detail[0]['points'];

        $('.question-' + id + ' .user_answer').html('<p>' + 'Ваш ответ: ' + user_answer + '</p>' + '<p>' + 'Правильный ответ: ' + real_answer + '</p>' + '<p>' + 'Кол-во набранных баллов: ' + points + '</p>');
        $('.question-' + id + ' input').val('');
        $('.question-' + id + ' .button-to-give-answer').remove();

        if(result){
            $('.question-' + id + ' .sign_correct').show();
        } else {
            $('.question-' + id + ' .sign_wrong').show();
        }
    })
});
