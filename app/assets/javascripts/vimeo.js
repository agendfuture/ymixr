function viSearch(searchString, show){
	
  var q = $('#search-form input.form-control').val();

  $.getJSON("/vimeo.json", {
    query : q
  }).success(function(response){
    viPrintTracks(response, show);
    $("#show-vi-results").show();
  });  
}

function viPrintTracks(response, show){
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
  		$(".search-result-list-vi").append(clone);
  	}); 

    $('.search-result-loading').hide();
    if (show) {$('.search-result-list-vi').show(1000);}
  }
}

function viShowResultList(){
  $('.search-result-list').hide();
  $('.search-result-list-vi').show(1000)
}

// --------- Player ------------

function viPlayerReady(player_id){
  player.viPlayer = $f(player_id);
  player.viPlayer.currentTime = 0;
  player.viPlayer.api("getDuration", viSetDuration);

  player.viPlayer.addEvent('finish', function(data){ player.next() });
  player.viPlayer.addEvent('play', playEventHandler);
  player.viPlayer.addEvent('pause', pauseEventHandler);
  player.viPlayer.addEvent('seek', function(data){ player.skipTo(data.seconds, true); });
}

function playEventHandler(){
  player.viPlayer.addEvent('pause', pauseEventHandler);
  player.viPlayer.removeEvent('play');
  if (!Player.playing)
    player.play();
}

function pauseEventHandler(){
  player.viPlayer.addEvent('play', playEventHandler);
  player.viPlayer.removeEvent('pause');
  if (Player.playing)
    player.stop();
}

function viSetDuration(duration, player_id){
  player.viPlayer.duration = duration;
  player.progressbar.slider({ max: player.viPlayer.duration });
  player.progressbar.show();
  player.play();
}


