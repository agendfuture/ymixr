class Ymixr.Models.PlaylistEntry extends Backbone.Model
  paramRoot: 'playlist_entry'

  defaults:
    position: null

class Ymixr.Collections.PlaylistEntriesCollection extends Backbone.Collection
  model: Ymixr.Models.PlaylistEntry
  url: '/playlist_entries'
