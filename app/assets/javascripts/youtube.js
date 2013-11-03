function ytSearch(searchString){
	if (gapiLoaded) {
    var q = $('#search-form input.form-control').val();
    var request = gapi.client.youtube.search.list({
      q: searchString,      
      part: 'snippet'
    });
  
    request.execute(ytPrintTracks);
  }
}

function ytPrintTracks(response){
	var tracks = response.result.items;
	var title, clone;
	if (!!templateCache) {
		tracks.forEach(function(track, index, array){
			clone = $(templateCache).clone();
			title = track.snippet.title.split("-");
  		clone.attr('data-song-id','yt:' + track.id.videoId);
  		clone.find(".artistname").html(title[0]);
  		clone.find(".songtitle").html(title[1]);
  		clone.find("img").attr('src', track.snippet.thumbnails.default.url);
  		$(".search-result-list").append(clone);
  	}); 

    $('.search-result-loading').hide();
    $('.search-result-list').show(1000);
  }
}

function ytLoadThumbnails(){
	if (gapiLoaded) {
    var q = playlist.playlist_entries.filter(function(index, element){
    		return element.song.type == "yt"; 
    	});
    q = q.map(function(index, element){ return element.song.id; }).toArray();
    var request = gapi.client.youtube.videos.list({
      id: q.join(),      
      part: 'snippet'
    });
  
    request.execute(function(response){
    	var items = response.result.items;
    	items.forEach(function(track, index, array){
    		$(".playlist li[data-song-id='yt:"+ track.id +"'] .search-thumbnail")
    			.css("background-image", "url("+ track.snippet.thumbnails.default.url +")");
    	});
    });
  }
}



$.Class("Clock", 
	{
		elapsedTime: 0,
		callback: null,
		intervalObj: null,
		interval: 1000
	}, 
	{
		start : function(callback, interval, seek){
			this.elapsedTime = seek;
			this.callback = callback;
			this.interval = interval;
			this.intervalObj = window.setInterval($.proxy(this.tick, this), this.interval);
		},
		stop : function(){
			window.clearInterval(this.intervalObj);
		},
		tick : function(){
			this.elapsedTime = this.elapsedTime + 1;
			this.callback(this.elapsedTime);
		}

 });