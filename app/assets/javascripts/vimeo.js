function viSearch(searchString){
	
  var q = $('#search-form input.form-control').val();

  $.getJSON("/vimeo.json", {
    query : q
  }).success(viPrintTracks);  
}

function viPrintTracks(response){
	var tracks = response.videos.video;
	var title, clone;
	if (!!templateCache) {
		tracks.forEach(function(track, index, array){
			clone = $(templateCache).clone();
			title = track.title.split("-");
  		clone.attr('data-song-id','vi:' + track.id);
  		clone.find(".artistname").html(title[0]);
  		clone.find(".songtitle").html(title[1]);
  		clone.find("img").attr('src', track.thumbnails.thumbnail[0]._content);
  		$(".search-result-list").append(clone);
  	}); 

    $('.search-result-loading').hide();
    $('.search-result-list').show(1000);
  }
}

// --------- Player ------------

function viPlayerReady(player_id){
  player.viPlayer = $f(player_id);
  player.play();
}