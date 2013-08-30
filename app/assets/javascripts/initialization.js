function submitSearch(){
  $('.search-result-loading, .search-result-container').show();
  $('.search-result-list').hide();

  serializedFilters = $(".sidebar-nav :input[name='source_filter']").serializeArray();
  form = $(this);
  serializedFilters.forEach(function(element, index, array){ 
        switch(element.value){
          case "yt":
          case "vi":
            var valuesToSubmit = form.serialize()+'&'+element.name+'='+element.value;
            $.ajax({
                url: form.attr('action'),
                data: valuesToSubmit
            }).success(function(result){                      
                $(".search-result-list").html(result);
                $('.search-result-loading').hide();
                $('.search-result-list').show(1000);
            });
            break;
          case "sc":   
            scSearch(form.find('input[name="song_search"]').val());            
        }
      }); 
  
  return false;
}

var player, playlist;

$(document).ready(function(){

  playlist = new Playlist();
  player = new Player(playlist);

  $(document).delegate(".player .btn-play", "click", player.togglePlayButton)          
            .delegate(".add-song", "click", playlist.add)
            .delegate(".play-song", "click", player.instantPlay)
            .delegate(".playlist-small li:not(.placeholder)", "dblclick", player.instantPlay)                
            .delegate(".playlist-small .close", "click", playlist.removeEvt)
            .delegate(".player .btn-forward", "click", $.proxy(player.next, player));
  
  $(".navbar-form").submit(submitSearch);
  $(".new_playlist").submit(function(){
    return false;
  });

  $(".search-result-list, .playlist-small" ).sortable({
    connectWith: ".connectedSortable",
    start : function(event, ui){
    },
    stop : function(event, ui){
    }
  }).disableSelection();
   
});

// 3. This function creates an <iframe> (and YouTube player)
      //    after the API code downloads.
function onYouTubeIframeAPIReady() {
  player.ytReady = true; 
};
