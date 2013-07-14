$.Class("Song", {
   staticInit : function(id, type, artist, title){
     switch (type){
       case "yt":
         return new YtSong(id, type, artist, title);
       case "sc":
         return new ScSong(id, type, artist, title);
     }
   },
   seek: 0
 },
 {
   init : function(id, type, artist, title){
     this.id = id;
     this.type = type;
  
     this.artist = artist;
     this.title = title;
   },
   play : function(){
      $('li[id="'+this.type+':'+this.id+'"]').addClass('playing');
   },
   stop : function(){
      $('li[id="'+this.type+':'+this.id+'"]').removeClass('playing');
   },
   skipTo : function(seconds){ },
   seek : function(){  return 0; }
});

Song.extend("YtSong",{
  loadInto : function(player){
    if(player.ytPlayer){
      player.ytPlayer.loadVideoById(this.id);
      player.play();
    }
    else
      player.ytPlayer = new YT.Player('ytPlayer', {
        videoId: this.id,
        events: {
          'onReady': $.proxy(player.ytOnReady, player),
          'onStateChange': $.proxy(player.onYtPlayerStateChange, player)
        }
      });
  },
  play : function(player){
    player.ytPlayer.playVideo();
    player.progressbar.slider("option", "max", player.ytPlayer.getDuration());
    this._super();
  },
  stop : function(player){
    player.ytPlayer.stopVideo();
    this._super();
  },
  pause : function(player){
    player.ytPlayer.pauseVideo();
  },
  skipTo : function(seconds){ 
    player.ytPlayer.seekTo(seconds);
    player.timer.elapsedTime = seconds;
  },
  seek : function(){
    return (player.ytPlayer.getCurrentTime())?(player.ytPlayer.getCurrentTime()):0;
  }
});

Song.extend("ScSong",{
  loadInto : function(player){
    SC.get("/tracks/"+this.id, {limit: 1}, function(tracks){
      player.progressbar.slider("option", "max", Math.round(tracks.duration/1000));
      player.progressbar.show();      
    });
    SC.stream("/tracks/"+this.id,{
      onfinish: player.next
    }, function(sound){
      player.scPlayer = sound;
      player.play();
    });
  },
  play : function(player){
    player.scPlayer.play();
    this._super();
  },
  stop : function(player){
    player.scPlayer.stop();
    this._super();
  },
  pause : function(player){
    player.scPlayer.pause();
  },
  skipTo : function(seconds){ 
    player.scPlayer.setPosition(seconds*1000);
    player.timer.elapsedTime = Math.round(player.scPlayer.position/1000);
  },
  seek : function(){
    return Math.round(player.scPlayer.position/1000);
  }
});
