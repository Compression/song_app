class SongsController < ApplicationController

  def index
    @song = Song.new
    @songs = Song.all
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to songs_path
    else
      @songs = Song.all
      flash[:notice] = "Your song did not save - please try again"
      render :index
    end
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist, :bpm, :genre)
  end
end
