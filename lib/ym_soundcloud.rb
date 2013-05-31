class YM_Soundcloud < YM_Plattform

  cattr_reader :client, :consumer

  def initialize(id)
    super(id.to_i) 

    song = @@client.Track.find(@id)
    @song_url = song.permalink_url
  end

  def get_player() 
    'songs/sc_play'
  end

  def client
    self.client
  end
  def consumer
    self.consumer
  end

  class << self
    def client
      if @@client.nil?
        self.init_client
      end
      @@client
    end
    def consumer
      if @@consumer.nil?
        self.init_client
      end
      @@consumer
    end
   
    def init_client
      @@consumer = Soundcloud.consumer(SoundcloudConfig.client_id, SoundcloudConfig.client_secret)
      @@client = Soundcloud.register(:access_token => @@consumer.get_request_token)
    end
  end

end
