class Ymixr.Models.Song extends Backbone.Model
  paramRoot: 'song'

  defaults:
    title: null
    url: null
    album: null
    artist: null
    play_count: null
    sid: null

class Ymixr.Collections.SongsCollection extends Backbone.Collection
  model: Ymixr.Models.Song
  url: '/songs'
