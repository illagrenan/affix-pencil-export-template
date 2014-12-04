$(function () {
    var sections = {},
        _height = $(window).height(),
        i = 0;

    // Grab positions of our sections
    $('.scrollto').each(function () {
        sections[this.name] = $(this).offset().top;
    });

    $(document).scroll(function () {
        var $this = $(this),
            pos = $this.scrollTop();

        for (i in sections) {
            if (sections[i] > pos && sections[i] < pos + _height) {
                $('a').removeClass('active');
                $('#nav_' + i).addClass('active');
            }
        }
    });
});

$(function () {
    // $('.list-group').stickyNavbar();
});
