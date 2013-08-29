function scSearch(searchString){
	$(".search-result-list").children().remove();
	SC.get("/tracks", {q: searchString}, scPrintTracks);
}

function scPrintTracks(tracks){
	$.get("/songs/soundcloudTemplate"
	).success(function(template){
		tracks.forEach(function(track, index, array){
			clone = $(template).clone();
  			clone.attr('data-song-id','sc:' + track.id);
  			clone.find(".artistname").html(track.user.username);
  			clone.find(".songtitle").html(track.title);
  			clone.find("img").attr('src', track.artwork_url);
  			$(".search-result-list").append(clone);
  		});        	
    });
}