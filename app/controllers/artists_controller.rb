class ArtistsController < ApplicationController
  # GET /djs/:dj_id/artists
  # GET /djs/:dj_id/artists.json
  def index
    @dj = Dj.find(params[:dj_id])
    @artists = @dj.artists.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @artists }
    end
  end

  # GET /djs/:dj_id/artists/:id
  # GET /djs/:dj_id/artists/:id.json
  def show
    @dj = Dj.find(params[:dj_id])
    @artist = params[:id]
    @songs = @dj.songs_by_artist(@artist).page(params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @songs }
    end
  end

end
