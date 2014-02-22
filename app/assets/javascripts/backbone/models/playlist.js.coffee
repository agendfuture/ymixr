class Ymixr.Models.Playlist extends Backbone.Model
  paramRoot: 'playlist'

  defaults:
    title: null
    description: null
    creator: null
    play_count: null

class Ymixr.Collections.PlaylistsCollection extends Backbone.Collection
  model: Ymixr.Models.Playlist
  url: '/playlists'
