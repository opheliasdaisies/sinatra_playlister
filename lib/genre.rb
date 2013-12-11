class Genre
  attr_accessor :name, :songs, :artists

  GENRES = []

  def initialize
    @name
    @songs = []
    @artists = []
    GENRES << self
  end

  def self.all
    GENRES
  end

  def self.reset_genres
    GENRES.clear
  end

  def song_count
    songs.length
  end

  def artist_count
    artists.length
  end

end