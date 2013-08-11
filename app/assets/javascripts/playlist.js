$.Class("Playlist", {
    recording : false,
    id : 0
  },{
   init : function(){

   },
   add : function(songElement){
     $(".playlist-small .placeholder").remove();
     $(".playlist-small").append($(this).closest("li") );

     /*if(recording)
      $.ajax({
        url : '/playlist/:id/add/'+this.type+':'+this.id  
        data : {artist : this.artist, title : this.title}      
      });*/
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
   },
   save : function(){

   },
   open : function(){

   },
   startRecording : function(){
    Playlist.recording = true;
   },
   list : function(){

   }/*,
   id : function(callback = function(){}){
    if this.id == 0
      $.getJSON('ajax/test.json', function(data) {
        playlist.id = data.id
        callback();
      });
    else
      return this.id
   }*/
});
