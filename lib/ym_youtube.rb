class YM_Youtube < YM_Plattform
  
  cattr_reader :client
  attr_reader :player
  def initialize(id)
    super(id)
  end

  def get_player()
    @player = YM_Youtube.client.video_by(@id).embed_html5({:class => 'yt-player', :width => '350', :height => '65'})
    'songs/yt_play'
  end

  class << self
    def client
      if @@client.nil?
        self.init_client
      end
      @@client
    end
    def init_client
      @@client ||= YouTubeIt::Client.new
    end
  end
end
