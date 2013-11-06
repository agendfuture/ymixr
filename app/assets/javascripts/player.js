/* Player class | wrapper for all the plattform players */
$.Class("Player",
  {
    scReady: false,
    playing: false,
    timer: null,
    progressbar: null,

    hideVideoPlayer : function(){
      $("#ytPlayer, #viPlayer").hide();
    }
  },
  {
    init : function(playlist) {
      this.actualSong = undefined;
      this.nextSong = undefined;
      this.playlist = playlist;
      this.progressbar = $("#progressbar").slider({
            min: 1,
            max: 60,
            range: "min",
            value: 0,
            slide: function( event, ui ){
              player.skipTo(ui.value);
            }
          });
      this.timer = new Clock();
    },    
    play : function(event){
      player.actualSong.play(player);
      Player.playing = true;
      player.timer.start(this.updateProgressbar, 1000, player.actualSong.seek());

      $(".btn-play i").addClass("icon-pause"); 
      $(".player .songtitle").text(player.actualSong.artist+" - "+player.actualSong.title); 
      $(".player").show();
    },
    instantPlay : function(event, settings){
      $(this).closest("li").addClass("instantPlay");
      playlist.addFirst($(this).closest("li"));
      player.next();     
    },
    stop : function(event){
      Player.playing = false;
      player.actualSong.pause(player);
      player.timer.stop();
      $(".btn-play i").removeClass("icon-pause");  
    },
    next : function(event){
      if (player.actualSong){
        playlist.remove(player.actualSong);
        player.actualSong.stop(player);
        player.timer.stop();
        player.timer.elapsedTime = 0;
      }
      if($(".playlist-small li:not(.placeholder)").length > 0){
          Player.hideVideoPlayer();
          player.actualSong = Song.createFromElement($(".playlist-small li:not(.placeholder):first"));  
          Player.playing = false;
          player.actualSong.loadInto(player);
      }else{
        player.stop();
      }      
    },
    skipTo : function(seconds, skippedInVideoPlayer){      
      player.actualSong.skipTo(seconds, skippedInVideoPlayer);
    },    
    togglePlayButton : function(event){
      if (!Player.playing){
        if (!player.actualSong)
	         player.next();
        else
           player.play(event);
      }else{
        player.stop(event);
      }
    },
    updateProgressbar : function(){
        player.progressbar.slider( "value", player.timer.elapsedTime );
    }
  });
