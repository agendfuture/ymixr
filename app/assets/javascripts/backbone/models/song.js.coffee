class YoumixrOR.Models.Song extends Backbone.Model
  paramRoot: 'song'

  defaults:
    title: null
    url: null
    album: null
    artist: null
    play_count: null
    sid: null

class YoumixrOR.Collections.SongsCollection extends Backbone.Collection
  model: YoumixrOR.Models.Song
  url: '/songs'
