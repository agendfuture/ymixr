$.Class("Playlist", {},{
   init : function(){

   },
   add : function(songElement){
     $(".playlist-small .placeholder").remove();
     $(".playlist-small").append($(this).closest("li") );
   },
   remove : function(song){
     $("#"+song.type+":"+song.id).first().remove();
   },
   removeElement : function(event){
     $(event.target).closest("li").remove();
   }
});
