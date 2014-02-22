class YoumixrOR.Models.Playlist extends Backbone.Model
  paramRoot: 'playlist'

  defaults:
    title: null
    description: null
    creator: null
    play_count: null

class YoumixrOR.Collections.PlaylistsCollection extends Backbone.Collection
  model: YoumixrOR.Models.Playlist
  url: '/playlists'
