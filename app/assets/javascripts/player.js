/* Player class | wrapper for all the plattform players */
$.Class("Player",
  {
    ytReady: false,
    scReady: false,
    playing: false
  },
  {
    init : function(playlist) {
      this.actualSong = undefined;
      this.nextSong = undefined;
      this.playlist = playlist;
    },
    ytOnReady : function(event){      
      player.ytPlayer.addEventListener('onStateChange', $.proxy(player.onPlayerStateChange, player));
      player.play();
    },
    play : function(event){
      Player.playing = true;
      player.actualSong.play(player);
      $(".btn-play i").addClass("icon-pause"); 
      $(".player .songtitle").text(player.actualSong.artist+" - "+player.actualSong.title); 
    },
    instantPlay : function(event){
      playlist.addFirst(this);
      player.next();
    },
    stop : function(event){
      Player.playing = false;
      player.actualSong.pause(player);
      $(".btn-play i").removeClass("icon-pause");  
    },
    next : function(event){
      if (player.actualSong){
        playlist.remove(player.actualSong);
        player.actualSong.stop(player);
      }
      if($(".playlist-small").children(":not(.placeholder)").length > 0){
          var element = $(".playlist-small li:eq(0)");
          var identifier = element.attr("id").split(":");
          player.actualSong = Song.staticInit(identifier[1],identifier[0],element.find(".artistname").text(),element.find(".songtitle").text());  
          Player.playing = false;
          player.actualSong.loadInto(player);
      }      
    },
    onPlayerStateChange : function(event){
      switch(event.data){
        case YT.PlayerState.ENDED:
          player.next();
          break;
        case YT.PlayerState.PLAYING:
          if(Player.playing == false)
            player.play(event);
          break;
        default:
          break;      
      }
    },
    togglePlayButton : function(event){
      if (Player.playing == false){
        if (!player.actualSong)
	         player.next();
        else
           player.play(event);
      }else{
        player.stop(event);
      }
    }
  });
