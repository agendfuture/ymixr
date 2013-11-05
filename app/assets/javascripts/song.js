$.Class("Song", {
   staticInit : function(id, type, artist, title){
    switch (type){
      case "yt":
         return new YtSong(id, type, artist, title);
      case "sc":
         return new ScSong(id, type, artist, title);
      case "vi":
         return new ViSong(id, type, artist, title);
     }
   },
   createFromElement : function(listElement){
      var identifier = listElement.attr("data-song-id").split(":");
      return Song.staticInit( identifier[1],
                              identifier[0],
                              listElement.find(".artistname").text(),
                              listElement.find(".songtitle").text());
   },
   getDOMElement : function(song){
      return $("li[data-song-id = '"+song.identifier()+"']");
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
      $('li[data-song-id="'+this.identifier()+'"]').addClass('playing');

      $.ajax({
        url : '/songs/'+this.identifier()+'/play',
        data : {artist : this.artist, title : this.title}
      });
   },
   stop : function(){
      $('li[data-song-id="'+this.identifier()+'"]').removeClass('playing');
   },
   skipTo : function(seconds){ },
   seek : function(){  return 0; },
   identifier : function(){ return this.type + ":" + this.id; }
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
    $("#ytPlayer").show();
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
    $(".hidden-player").hide();
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
    player.scPlayer.setPosition(seconds * 1000);
    player.timer.elapsedTime = Math.round(player.scPlayer.position/1000);
  },
  seek : function(){
    return Math.round(player.scPlayer.position/1000);
  }
});

Song.extend("ViSong",{
  loadInto : function(player){
    $.getJSON("http://vimeo.com/api/oembed.json", {
      url : "http://vimeo.com/" + this.id,
      width : 640,
      player_id : "viIframe"
    }).success(function(response){
      $("#viPlayer").html(response.html);
      $("#viPlayer iframe").attr("id", "viIframe");
      $f("viIframe").addEvent('ready', viPlayerReady);

      $("#viPlayer").show();        
    });   
  },
  play : function(player){
    player.viPlayer.api("play");
    player.viPlayer.currentTime = 0;
    this._super();
  },
  stop : function(player){
    player.viPlayer.api("stop");
    this._super();
  },
  pause : function(player){
    player.viPlayer.api("pause");
  },
  skipTo : function(seconds){ 
    player.viPlayer.api("seekTo", seconds);
    player.timer.elapsedTime = seconds;
  },
  seek : function(){

    return player.viPlayer.currentTime;
  }
});