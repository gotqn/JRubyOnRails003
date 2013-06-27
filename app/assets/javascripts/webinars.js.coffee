$(document).ready ->
  Webinars.Functions.Initialize.Search()
  Webinars.Functions.Initialize.Video()

if typeof Webinars is "undefined"
  Webinars =
    Variables: {}
    Functions:
      Initialize:
        Search: ->
          $("#search_search_name").autocomplete source: $("#search_search_name").data("autocomplete-source")

        Video: ->
          $("video").mediaelementplayer()



#$(document).ready(function(){
#    Webinars.Functions.Initialize.Search();
#    Webinars.Functions.Initialize.Video();
#});
#
#if(typeof Webinars === 'undefined'){
#
#    Webinars = {
#
#        Variables:{
#
#        },
#
#        Functions:{
#
#            Initialize:{
#
#                Search:function(){
#                    $('#search_search_name').autocomplete({
#                        source: $('#search_search_name').data('autocomplete-source')
#                    });
#                },
#
#                Video:function(){
#                    $('video').mediaelementplayer(/* Options */);
#                }
#            }
#        }
#    };
#}
