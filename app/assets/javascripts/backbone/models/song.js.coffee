class Ymixr.Models.Song extends Backbone.RelationalModel
  paramRoot: 'song'

  defaults:
    title: null
    url: null
    album: null
    artist: null
    play_count: null
    sid: null

  relations: [{
    type: Backbone.HasMany
    key: 'playlist_entries'
    relatedModel: 'PlaylistEntry'
    reverseRelation: {
      key: 'song'
    }
  }]

class Ymixr.Collections.SongsCollection extends Backbone.Collection
  model: Ymixr.Models.Song
  url: '/songs'
