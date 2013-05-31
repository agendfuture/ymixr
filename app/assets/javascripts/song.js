$.Class("Song",{
   staticInit : function(id, type, artist, title){
     switch (type){
       case "yt":
         return new YtSong(id, type, artist, title);
       case "sc":
         return new ScSong(id, type, artist, title);
     }
   }
 },
 {
   init : function(id, type, artist, title){
     this.id = id;
     this.type = type;
  
     this.artist = artist;
     this.title = title;
   },
   play : function(){

   },
   stop : function(){

   }
});

Song.extend("YtSong",{
  loadInto : function(player){
    if(player.ytPlayer){
      player.ytPlayer.loadVideoById(this.id);
    }
    else
      player.ytPlayer = new YT.Player('ytPlayer', {
        videoId: this.id,
        events: {
          'onReady': $.proxy(Player.play, Player),
          'onStateChange': $.proxy(Player.onPlayerStateChange, Player)
        }
      });
  },
  play : function(player){
    player.ytPlayer.playVideo();
  },
  stop : function(player){
    player.ytPlayer.stopVideo();
  },
  pause : function(player){
    player.ytPlayer.pauseVideo();
  }
});

Song.extend("ScSong",{
  loadInto : function(player){
    // get URI
    SC.get("/tracks/"+this.id,{limit:1},function(tracks){
      player.scPlayer.load(tracks.permalink_url);
    });
  },
  play : function(player){
    player.scPlayer.play();
  },
  stop : function(player){
    player.scPlayer.stop();
  },
  pause : function(player){
    player.scPlayer.pause();
  }
});
