$(document).on('turbolinks:load', function(){

    // Edit course

    $('form.edit-course_form').on('ajax:success', function(e) {
        var title = e.detail[0]['title'];
        var id = e.detail[0]['id'];

        $('.course-' + id + ' .course-title a').html(title);
        // $('.question-' + id + ' input').val('');
    }).on('ajax:error', '.edit-course_form', function (e) {
        var errors = e.detail[0]['errors'];
        $('.flash-block').html(errors)
    });

    const editButton = $('.edit-course_button');
    if (editButton.length) {
        editButton.on('click', showCourseForm);
    }

    const saveButton = $('.save-course_button');
    if (saveButton.length) {
        saveButton.on('click', hideCourseForm);
    }
});

function showCourseForm() {
    const id = $(this).attr("data-id");

    $('.course__form-edit-' + id).show(300);
}

function hideCourseForm() {
    const id = $(this).attr("data-id");
    $('.course__form-edit-' + id).hide(300);
}
