document.addEventListener('turbolinks:load', function() {

    // Comment Vote update
    const commentVotes = $('.comment-votes');
    if(commentVotes.length){
        commentVotes.on('ajax:success', '.vote', function(e) {
            var xhr = e.detail[0];
            var rating = xhr['rating'];
            var commentId = xhr['votable_id'];
            $('.comment-' + commentId + ' .rating').html('<b>' + rating + '</b>');

        }).on('ajax:error', '.vote', function (e) {
            var errors = e.detail[0];
            $('.notice').html(errors)
        });
    }
});
