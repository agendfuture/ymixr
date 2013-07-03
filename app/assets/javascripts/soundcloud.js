function scSearch(searchString){
	$(".search-result-list").children().remove();
	SC.get("/tracks", {q: searchString}, printTracks);
}

function printTracks(tracks){
	$.ajax({
        	url: "/songs/soundcloudTemplate"
    	}).success(function(template){
			tracks.forEach(function(track, index, array){
				clone = $(template).clone();
	  			clone.attr('id','sc:' + track.id);
	  			clone.find(".artistname").html(track.user.username);
	  			clone.find(".songtitle").html(track.title);
	  			clone.find("a.close").attr('href','/playlists/sc:'+track.id+'/remove');
	  			clone.find("a.play-song-btn").attr('href','/songs/sc:'+track.id+'/play');
	  			clone.find("a.add-song-btn").attr('href','/playlists/sc:'+track.id+'/add');
	  			clone.find("img").attr('src', track.artwork_url);
	  			$(".search-result-list").append(clone);
	  		});        	
        });
}