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

    get "/songs/:name" do
      song_name = params[:name]
      @song = @playlist.song_match(song_name)
      
      erb :song_profile
    end

    post "/search" do
      @search_term = params["search"]
      @results = search(@search_term)
      
      erb :search
    end

    helpers do
      def pluralize(word, count)
        count > 1 ? word + "s" : word
      end

      def search(word)
        results = []
        word_to_find = word.downcase
        @playlist.all_songs.each do |item|
          if item.name.downcase.include?(word_to_find) || item.artist.name.downcase.include?(word_to_find) || item.genre.name.downcase.include?(word_to_find)
            results << "<a href='/songs/#{item.name}'>#{item.name}</a> by <a href='/artists/#{item.artist.name}'>#{item.artist.name}</a>"
          end
        end
        results
      end
    end

  end
end