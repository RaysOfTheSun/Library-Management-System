$('body').on('mouseenter mouseleave', '.dropdown', function (e) {
    var dropdown = $(e.target).closest('.dropdown');
    var menu = $('.dropdown-menu', dropdown);
    dropdown.addClass('show');
    menu.addClass('show');
    setTimeout(function () {
        dropdown[dropdown.is(':hover') ? 'addClass' : 'removeClass']('show');
        menu[dropdown.is(':hover') ? 'addClass' : 'removeClass']('show');
    }, 30);
});