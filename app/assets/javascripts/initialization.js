function submitSearch(){
  $('.search-result-loading, .search-result-container').show();
  $('.search-result-list').hide();
  $(".search-result-list").children().remove();

  requestResultTemplate(function(template){ templateCache = template;})

  serializedFilters = $(".sidebar-nav :input[name='source_filter']").serializeArray();
  form = $(this);
  serializedFilters.forEach(function(element, index, array){ 
        switch(element.value){
          case "yt":
            ytSearch(form.find('input[name="song_search"]').val());
            break;
          case "vi":
            viSearch(form.find('input[name="song_search"]').val());
            break;
          case "sc":   
            scSearch(form.find('input[name="song_search"]').val());            
        }
      }); 
  
  return false;
}

function requestResultTemplate(handler){
  $.get("/songs/soundcloudTemplate").success(handler);
}

var player, playlist;
var gapiLoaded = false;
var templateCache;

$(document).ready(function(){

  playlist = new Playlist();
  playlist.initialize();
  player = new Player(playlist);

  $(document).delegate(".player .btn-play", "click", player.togglePlayButton)          
            .delegate(".add-song", "click", playlist.add)
            .delegate(".play-song", "click", player.instantPlay)
            .delegate(".playlist-small li:not(.placeholder)", "dblclick", player.instantPlay)                
            .delegate(".playlist-small .close", "click", playlist.removeEvt)
            .delegate(".player .btn-forward", "click", $.proxy(player.next, player));
  
  $(".navbar-form, .sidebar-nav").submit(submitSearch);

  $(".new_playlist").bind('ajax:success', function(evt, data, status, xhr){
    $('.playlist-title').html(' - <a class="btn-link" href="/playlists/'+data.id+'">'+data.title+'</a>');
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
