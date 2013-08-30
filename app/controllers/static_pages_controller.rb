class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def run
	if !session[:playlist].nil?
        @playlist_entries = Song.all(:joins => :playlist_entries, 
                    :conditions => {:playlist_entries => {:playlist_id => session[:playlist].id}}, 
                    :select => 'songs.*, playlist_entries."order", playlist_entries.id as playlist_entry_id')
    end

	render template: "layouts/index"
  end

end
