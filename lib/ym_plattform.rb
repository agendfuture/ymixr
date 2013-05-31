class YM_Plattform

  attr_reader :id, :song_url

  class << self
    def create(descriptor)
      desc = descriptor.split(':')

      case desc[0]
      when 'yt'
        YM_Youtube.new(desc[1])
      when 'sc'
        YM_Soundcloud.new(desc[1])
      when 'vi'
    
      else
     
      end
    end 
  end

  def initialize(id)
    @id = id
  end

  def get_player

  end

  def init_client
    raise "not a Plattform"
  end 
end
