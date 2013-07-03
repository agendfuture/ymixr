function hello(){

alert("Hello World");  
}

$.Class("Song", {
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
      $('li[id="'+this.type+':'+this.id+'"]').addClass('playing');
   },
   stop : function(){
      $('li[id="'+this.type+':'+this.id+'"]').removeClass('playing');
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
          'onReady': $.proxy(player.ytOnReady, player),
          'onStateChange': $.proxy(player.onPlayerStateChange, player)
        }
      });
  },
  play : function(player){
    player.ytPlayer.playVideo();
    this._super();
  },
  stop : function(player){
    player.ytPlayer.stopVideo();
    this._super();
  },
  pause : function(player){
    player.ytPlayer.pauseVideo();
  }
});

Song.extend("ScSong",{
  loadInto : function(player){
    SC.stream("/tracks/"+this.id,function(sound){
      player.scPlayer = sound;
      player.play();
    });
  },
  play : function(player){
    /*SC.stream("/tracks/293", function(sound){
      sound.play();
    });*/
    player.scPlayer.play();
    this._super();
  },
  stop : function(player){
    player.scPlayer.stop();
    this._super();
  },
  pause : function(player){
    player.scPlayer.pause();
  }
});
