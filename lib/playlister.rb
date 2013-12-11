class Playlister
	attr_reader :all_songs

	def initialize(songs)	
		@all_songs = songs
	end

	def artist_match(artist_choice)
		Artist.all.each do |artist|
			if artist.name == artist_choice
				return artist
			end
		end
	end

	def genre_match(genre_choice)
		Genre.all.each do |genre|
			if genre_choice == genre.name
				return genre
			end
		end
	end

	def song_match(song_choice)
		all_songs.each do |song|
			if song.name == song_choice
				return song
			end
		end
	end

end



