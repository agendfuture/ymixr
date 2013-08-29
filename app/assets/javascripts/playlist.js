$.Class("Playlist", {
    indexOf : function(song, order){
      for (var i = 0; i < playlist.playlist_entries.length; i++){
        if (song == playlist.playlist_entries[i].song && order == playlist.playlist_entries[i].order )
          return i;
      }      
    }
  },{
   init : function(){      
      this.playlist_entries = $(".playlist-small li:not(.placeholder)").map(function(index, listElement){return PlaylistEntry.createEntry($(listElement))});
   },
   add : function(event){
      $(".playlist-small .placeholder").hide();
      songElement = $(this).closest("li");
      $(".playlist-small").append(songElement);
      song = Song.createFromElement(songElement);

      $.ajax({
        url : '/playlist/addSong/'+song.identifier(),  
        data : {artist : song.artist, title : song.title}   
      }).success(function(result){
        entry = new PlaylistEntry(song, $.parseJSON(result).order);
        playlist.playlist_entries.push(entry);
        songElement.find(".close").attr('href','/playlist/removeSong/'+ song.identifier() + '/' + entry.order);
      });

      return false
   },
   addFirst : function(songElement){
     $(".playlist-small .placeholder").hide();
     $(".playlist-small").prepend(songElement );
   },
   removeEvt : function(event){
    playlist.remove(Song.createFromElement($(event.target).closest("li")));
   },
   remove : function(song){
     $(Song.getDOMElement(song)).remove();
   },
   save : function(){

   },
   open : function(){

   },
   list : function(){

   }
});

$.Class("PlaylistEntry", { 
  createEntry : function(listElement){
    return new PlaylistEntry(Song.createFromElement(listElement), parseInt(listElement.attr("data-playlist-order")))
  }
}, {
  init : function(song, order){
    this.song = song;
    this.order = order;
  },
  delete : function(){
    $.ajax({
        url : '/playlist/removeSong/'+this.song.identifier()+"/"+this.order        
      }).success(function(result){
        playlist.playlist_entries.splice(playlist.indexOf(this.song, this.order), 1);
      });
  }
});
