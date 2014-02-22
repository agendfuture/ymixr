function submitSearch(){
  $('.search-result-loading, .search-result-container').show();
  $('.search-result-list, .search-results-header .btn').hide();
  $(".search-result-list").children().remove();

  requestResultTemplate();

  serializedFilters = $(".sidebar-nav :input[name='source_filter']").serializeArray();
  form = $(this);
  firstResultPage = serializedFilters[0];
  if (firstResultPage) {$("#show-"+ firstResultPage.value +"-results").addClass("active");}
  serializedFilters.forEach(function(element, index, array){ 
        switch(element.value){
          case "yt":
            ytSearch(form.find('input[name="song_search"]').val(), (firstResultPage.value == element.value));
            break;
          case "vi":
            viSearch(form.find('input[name="song_search"]').val(), (firstResultPage.value == element.value));
            break;
          case "sc":   
            scSearch(form.find('input[name="song_search"]').val(), (firstResultPage.value == element.value));   
            break;         
        }
      }); 
  return false;
}

function requestResultTemplate(){
  $.get("/songs/soundcloudTemplate").success(function(template){ 
    templateCache = template;
  });
}

function finishSearchRequest(){
  $('.search-result-loading').hide();
  $('.search-results-header').show();
}

var player, playlist;
var gapiLoaded = false;
var templateCache;

$(document).ready(function(){

  playlist = new Playlist2();
  playlist.initialize();
  player = new Player(playlist);

  $(document).delegate(".player .btn-play", "click", player.togglePlayButton)          
            .delegate(".add-song", "click", playlist.add)
            .delegate(".play-song", "click", player.instantPlay)
            .delegate(".playlist-small li:not(.placeholder)", "dblclick", player.instantPlay)                
            .delegate(".playlist-small .close", "click", playlist.removeEvt)
            .delegate(".player .btn-forward", "click", $.proxy(player.next, player))
            .delegate("#show-yt-results", "click", ytShowResultList)
            .delegate("#show-sc-results", "click", scShowResultList)
            .delegate("#show-vi-results", "click", viShowResultList)
            .delegate("#show-yt-results, #show-sc-results, #show-vi-results", "click", 
                          function(element){
                            $("#show-yt-results, #show-sc-results, #show-vi-results").removeClass("active");
                            $(this).addClass("active");
                          });

  $(".navbar-form, .sidebar-nav").submit(submitSearch);

  $(".new_playlist").bind('ajax:success', function(evt, data, status, xhr){
    $('.playlist-title').html(' - <a class="btn-link" href="/playlists/' + data.id + '">' + data.title + '</a>');
  });

  $(".search-result-list, .playlist-small" ).sortable({
    connectWith: ".connectedSortable",
    start : function(event, ui){
    },
    stop : function(event, ui){
    }
  }).disableSelection();

  $( ".playlist-small" ).on( "sortupdate", playlist.reorder);
   
});
