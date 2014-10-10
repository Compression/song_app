class SongsController < ApplicationController
  http_basic_authenticate_with name:"admin", password: ENV["EDIT_PASSWORD"]
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

  def edit
    @songs = Song.all
  end

  def destroy
    song = Song.find(params[:id])
    if song.destroy
      flash[:notice] = "You've successfully deleted this bullshit."
    else
      flash[:alert] = "oh WTF. didn't work."
    end

    redirect_to "/songs/1/edit"
  end

  private

  def song_params
    params.require(:song, :id).permit(:title, :artist, :bpm, :genre)
  end
end
