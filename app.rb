require "bundler"
require_relative "./lib/artist.rb"
require_relative "./lib/genre.rb"
require_relative "./lib/song.rb"
require_relative "./lib/parser.rb"
require_relative "./lib/playlister.rb"
Bundler.require

module Playlist
  class PlaylisterApp < Sinatra::Application

    before do
      @playlist = Playlister.new(Parser.new("./public/data").song_list)
    end

    get "/" do
      erb :select
    end

    get "/artists" do
      @all_artists = Artist.all

      erb :artists
    end

    get "/genres" do
      @all_genres = Genre.all.sort_by { |genre| genre.songs.length}.reverse

      erb :genres
    end

    get "/artists/:name" do
      artist_name = params[:name]
      @artist = @playlist.artist_match(artist_name)
      @song_or_songs = pluralize("Song", @artist.songs_count)
      
      erb :artist_profile
    end

    get "/genres/:name" do
      genre_name = params[:name]
      @genre = @playlist.genre_match(genre_name)
      @song_or_songs = pluralize("Song", @genre.song_count)
      @artist_or_artists = pluralize("Artist", @genre.artist_count)

      erb :genre_profile
    end


        # puts "The #{genre.name.capitalize} genre has #{genre.songs.length} Songs and #{genre.artists.length} Artists:"
        # genre.songs.each do |song|
        #   puts "#{genre.songs.index(song)+1}. #{song.name} -- #{song.artist.name}"
        # end
        # return true

    helpers do
      def pluralize(word, count)
        count > 1 ? word + "s" : word
      end
    end

  end
end