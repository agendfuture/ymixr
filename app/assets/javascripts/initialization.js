var player, playlist;

$(document).ready(function(){
     SC.initialize({
       client_id: '4534af5d3c15ffc9c03f4ee826ad5265'
     });

     playlist = new Playlist();
     player = new Player(playlist);
    
     $(document).delegate(".player .btn-play", "click", player.togglePlayButton)          
                .delegate(".add-song-btn", "click", playlist.add)
                .delegate(".play-song-btn", "click", player.instantPlay)
                .delegate(".playlist-small li", "dblclick", player.instantPlay)
                .delegate(".playlist-small .close", "click", playlist.removeElement)
                .delegate(".player .btn-forward", "click", $.proxy(player.next, player));

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
function onSoundcloudAPIReady(){
  player.scReady = true;
};
