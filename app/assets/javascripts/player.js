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

      this.scPlayer = SC.Widget("scPlayer");
      this.scPlayer.bind(SC.Widget.Events.READY, onSoundcloudAPIReady);
    },
    play : function(event){
      Player.Class.playing = true;
      this.actualSong.play(this);
      $(".btn-play i").addClass("icon-pause"); 
      $(".player .songtitle").text(this.actualSong.artist+" - "+this.actualSong.title); 
    },
    stop : function(event){
      Player.Class.playing = false;
      this.actualSong.pause(this);
      $(".btn-play i").removeClass("icon-pause");  
    },
    next : function(event){
      if (this.actualSong){
        Playlist.remove(this.actualSong);
        this.actualSong.stop(this);
        this.actualSong = this.nextSong;
      }else{
        if($(".playlist-small").children(":not(.placeholder)").length > 0) 
           var element = $(".playlist-small li:eq(0)");
           var identifier = element.attr("id").split(":");
           this.actualSong = Song.staticInit(identifier[1],identifier[0],element.find(".artistname").text(),element.find(".songtitle").text());  
      }
      if($(".playlist-small").children(":not(.placeholder)").length > 1){ 
        var element = $(".playlist-small li:eq(1)");
        var identifier = element.attr("id").split(":");
        this.nextSong = Song.staticInit(identifier[1],identifier[0],element.find(".artistname").text(),element.find(".songtitle").text());  
      }        
      if(this.actualSong){
	this.actualSong.loadInto(this);
      }
    },
    onPlayerStateChange : function(event){
      if(event.data == YT.PlayerState.ENDED)
        this.next();
    },
    togglePlayButton : function(event){
      if (Player.Class.playing == false){
        if (!Player.actualSong)
	  Player.next();
        else
          Player.play(event);
      }else{
        Player.stop(event);
      }
    }
  });
