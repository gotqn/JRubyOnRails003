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
                    $(currentMenu).find('a.e-label').addClass('e-label-open');
                    if(index > 0){
                        $(currentMenu).addClass('e-menu-before-open-menu-all');
                    } else{
                        $(currentMenu).addClass('e-menu-before-open-menu-first');
                    }
                    isOpen = true;
                }
            });

            $(icon).on('click',function(event){

                if(isOpen){
                    if(event){
                        event.stopPropagation();
                    }
                    isOpen = false;
                    $(currentMenu).removeClass('e-menu-open');
                    $(currentMenu).find('a.e-label').removeClass('e-label-open');
                    if(index > 0){
                        $(currentMenu).removeClass('e-menu-before-open-menu-all');
                    } else{
                        $(currentMenu).removeClass('e-menu-before-open-menu-first');
                    }
                    return false;
                }
            });
        });
    }());
});
