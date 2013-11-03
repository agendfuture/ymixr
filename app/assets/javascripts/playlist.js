$.Class("Playlist", {
    indexOf : function(song, entry_id){
      for (var i = 0; i < playlist.playlist_entries.length; i++){
        if (song == playlist.playlist_entries[i].song && entry_id == playlist.playlist_entries[i].entry_id )
          return i;
      }      
    }
  },{
   init : function(){      
      this.playlist_entries = $(".playlist-small li:not(.placeholder)").map(function(index, listElement){return PlaylistEntry.createEntry($(listElement))});      
   },
   initialize : function(){
      scLoadThumbnails();
   },
   add : function(event){
      $(".playlist-small .placeholder").hide();
      var listElement = $(this).closest("li");
      $(".playlist-small").append(listElement);
      song = Song.createFromElement(listElement);

      $.ajax({
        url : '/playlists/addSong/'+song.identifier(),  
        data : {artist : song.artist, title : song.title}   
      }).success(function(result){
        var entry = new PlaylistEntry(song, $.parseJSON(result).id);
        playlist.playlist_entries.push(entry);
        listElement.find(".close").attr('href','/playlists/removeSong/'+ entry.entry_id);
        listElement.attr("data-entry-id", entry.entry_id);
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
   reorder : function(event, ui){
      var next = ($(ui.item).next().length > 0) ? ("/" + $(ui.item).next().attr("data-entry-id")) : "";
      $.ajax({
        url : '/playlists/reorder/' + ui.item.attr("data-entry-id") + next
      });
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
    return new PlaylistEntry(Song.createFromElement(listElement), parseInt(listElement.attr("data-entry-id")))
  }
}, {
  init : function(song, id){
    this.song = song;
    this.entry_id = id;
  },
  delete : function(){
    $.ajax({
        url : '/playlists/removeSong/'+this.entry_id        
      }).success(function(result){
        playlist.playlist_entries.splice(playlist.indexOf(this.song, this.entry_id), 1);
      });
  }
});
