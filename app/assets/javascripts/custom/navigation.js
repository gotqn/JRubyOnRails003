$(document).ready(function(){

    (function MenuInitialized(){

        $('.b-menu-container').each(function(index){

            var currentMenu = $(this);

            var isOpen = false;
            var trigger = $(this).find('div.e-trigger');
            var icon = $(trigger).find('span.e-icon-menu');

            $(trigger).on('click',function(){

                if(!isOpen){
                    $('.b-menu-container.e-menu-open span.e-icon-menu').trigger('click');
                    $(currentMenu).addClass('e-menu-open');
                    if(index > 0){
                        $(currentMenu).addClass('e-mene-before-open-mene');
                    }
                    isOpen = true;
                }
            });

            $(icon).on('click',function(){

                if(isOpen){
                    if(event){
                        event.stopPropagation();
                    }
                    isOpen = false;
                    $(currentMenu).removeClass('e-menu-open');
                    if(index > 0){
                        $(currentMenu).removeClass('e-mene-before-open-mene');
                    }
                    return false;
                }
            });
        });
    }());
});
