class Ymixr.Models.Playlist extends Backbone.RelationalModel
  paramRoot: 'playlist'

  defaults:
    title: null
    description: null
    creator: null
    play_count: null

  relations: [{
    type: Backbone.HasMany
    key: 'playlist_entries'
    relatedModel: 'PlaylistEntry'
    reverseRelation: {
      key: 'playlist'
    }
  }]


class Ymixr.Collections.PlaylistsCollection extends Backbone.Collection
  model: Ymixr.Models.Playlist
  url: '/playlists'
