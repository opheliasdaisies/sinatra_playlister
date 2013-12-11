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

    # get "/genres/:name" do
    #   @genre_name = params[:name].to_s

    #   erb :genre_profile
    # end


    helpers do
      def pluralize(word, count)
        count > 1 ? word + "s" : word
      end
    end

  end
end