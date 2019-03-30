$(document).on('turbolinks:load', function(){

    // Answer response

    $('form.answer-for-question_form').on('ajax:success', function(e) {
        var id = e.detail[0]['id'];
        var user_answer = e.detail[0]['user_answer'];
        var real_answer = e.detail[0]['real_answer'];
        var result = e.detail[0]['result'];
        var points = e.detail[0]['points'];
        var all_points = e.detail[0]['all_points'];

        $('.question-' + id + ' .user-answer_result').html('<p>' + user_answer +'</p>');
        $('.question-' + id + ' .right-answer_result').html('<p>' + real_answer +'</p>');
        $('.question-' + id + ' .user-points_result').html('<p>' + points +'</p>');
        $('.current_points').html('<p>' + all_points +'</p>');
        $('.question-' + id + ' input').val('');
        $('.question-' + id + ' .answer-for-question_form').remove();

        if(result){
            $('.question-' + id + ' .sign_correct').show();
        } else {
            $('.question-' + id + ' .sign_wrong').show();
        }
    })
});
