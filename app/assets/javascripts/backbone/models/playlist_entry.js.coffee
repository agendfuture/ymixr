class YoumixrOR.Models.PlaylistEntry extends Backbone.Model
  paramRoot: 'playlist_entry'

  defaults:
    position: null

class YoumixrOR.Collections.PlaylistEntriesCollection extends Backbone.Collection
  model: YoumixrOR.Models.PlaylistEntry
  url: '/playlist_entries'
