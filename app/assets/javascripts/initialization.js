var Player, Playlist;

$(document).ready(function(){
     SC.initialize({
       client_id: '4534af5d3c15ffc9c03f4ee826ad5265'
     });

     Playlist = new Playlist();
     Player = new Player(Playlist);
    
     $(document).delegate(".player .btn-play", "click", Player.togglePlayButton)          
                .delegate(".add-song-btn", "click", Playlist.add)
                .delegate(".playlist-small .close", "click", Playlist.removeElement)
                .delegate(".player .btn-forward", "click", $.proxy(Player.next, Player));

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
  Player.ytReady = true; 
}
function onSoundcloudAPIReady(){
  Player.scReady = true;
}
