jQuery(function ($) {
    var song_length = 340;
    var song_length_m = parseInt(song_length / 60);
    var song_length_s = song_length - song_length_m * 60;
    song_length_m = song_length_m > 9 ? song_length_m : "0" + song_length_m;
    song_length_s = song_length_s > 9 ? song_length_s : "0" + song_length_s;
    $('#mins').html(song_length_m + ":" + song_length_s);
    $('.progress').on('click', function (e) {
        let value = e.offsetX * 100 / this.clientWidth;
        console.log(value);
        var played = parseInt(song_length * value / 100);
        var played_m = parseInt(played / 60);
        var played_s = played - played_m * 60;
        played_m = played_m > 9 ? played_m : "0" + played_m;
        played_s = played_s > 9 ? played_s : "0" + played_s;
        $('#played').html(played_m + ":" + played_s);
        $(this).find('.progress-bar').css('width', value + "%");
        //video.currentTime = duration * (value / 100);
    });
    function rewind(event) {
        if (inRange(event)) {
            player.currentTime = player.duration * getCoefficient(event);
        }
    }

    $('.btn-backward').on('click', function () {
        let value = parseInt($('#wpdm-audio-player .progress-bar').css('width')) / parseInt($('#wpdm-audio-player .progress').css('width')) * 100 - 10;
        if (value < 0) value = 0;
        var played = parseInt(song_length * value / 100);
        var played_m = parseInt(played / 60);
        var played_s = played - played_m * 60;
        played_m = played_m > 9 ? played_m : "0" + played_m;
        played_s = played_s > 9 ? played_s : "0" + played_s;
        $('#played').html(played_m + ":" + played_s);
        $('#wpdm-audio-player .progress-bar').css('width', value + "%");
    });
    $('.btn-forward').on('click', function () {
        let value = parseInt($('#wpdm-audio-player .progress-bar').css('width')) / parseInt($('#wpdm-audio-player .progress').css('width')) * 100 + 10;
        if (value > 100) value = 100;
        var played = parseInt(song_length * value / 100);
        var played_m = parseInt(played / 60);
        var played_s = played - played_m * 60;
        played_m = played_m > 9 ? played_m : "0" + played_m;
        played_s = played_s > 9 ? played_s : "0" + played_s;
        $('#played').html(played_m + ":" + played_s);
        $('#wpdm-audio-player .progress-bar').css('width', value + "%");
    });
    $('.btn-volumctrl').on('click', function () {
        $(this).next('.volumctrl').toggle();
    });
    $('body').on('click', '.btn-play', function () {
        if ($(this).find('.fa').hasClass('fa-play'))
            $(this).find('.fa').addClass('fa-pause').removeClass('fa-play');else

            $(this).find('.fa').addClass('fa-play').removeClass('fa-pause');
    });
});
//# sourceURL=pen.js