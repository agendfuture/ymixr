$.Class("Playlist", {},{
   init : function(){

   },
   add : function(songElement){
     $(".playlist-small .placeholder").remove();
     $(".playlist-small").append($(this).closest("li") );
   },
   addFirst : function(songElement){
     $(".playlist-small .placeholder").remove();
     $(".playlist-small").prepend($(songElement).closest("li") );
   },
   remove : function(song){
     $('.playlist-small li[id="'+song.type+':'+song.id+'"]').first().remove();
   },
   removeElement : function(event){
     $(event.target).closest("li").remove();
   }
});
