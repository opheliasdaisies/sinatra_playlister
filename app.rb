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

    end

    get "/artists/:name" do
      @artist_name = proc[:name].to_s

      erb :artist_profile
    end

  end
end