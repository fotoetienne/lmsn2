class SongsController < ApplicationController
  load_and_authorize_resource
  #http://blog.8thcolor.com/2011/08/nested-resources-with-independent-views-in-ruby-on-rails/
  # GET /songs
  # GET /songs.json
  def index
    @dj = Dj.find(params[:dj_id])
    @songs = @dj.songs.order("title","artist").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @songs }
    end
  end

  # GET /songs/search
  # GET /songs/search.json
  def search
    @dj = Dj.find(params[:dj_id])
    @query = params[:query]
    @songs = Song.search :page => params[:page], :per_page => 100, :routing => @dj.id do |search|
      search.query do |query|
        query.string @query
      end
      search.filter :terms, :dj_id => [@dj.id]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @songs }
    end
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    @dj = Dj.find(params[:dj_id])
    @song = @dj.songs.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @song }
    end
  end

  # GET /songs/new
  # GET /songs/new.json
  def new
    @dj = Dj.find(params[:dj_id])
    @song = @dj.songs.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @song }
    end
  end

  # GET /songs/1/edit
  def edit
    @dj = Dj.find(params[:dj_id])
    @song = @dj.songs.find(params[:id])
  end

  # POST /songs
  # POST /songs.json
  def create
    @dj = Dj.find(params[:dj_id])
    @song = @dj.songs.new(params[:song])

    respond_to do |format|
      if @song.save
        format.html { redirect_to [@dj,@song], notice: 'Song was successfully created.' }
        format.json { render json: @song, status: :created, location: [@dj,@song] }
      else
        format.html { render action: "new" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /songs/1
  # PUT /songs/1.json
  def update
    @dj = Dj.find(params[:dj_id])
    @song = @dj.songs.find(params[:id])

    respond_to do |format|
      if @song.update_attributes(params[:song])
        format.html { redirect_to [@dj,@song], notice: 'Song was successfully created.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @dj = Dj.find(params[:dj_id])
    @song = @dj.songs.find(params[:id])
    @song.destroy

    respond_to do |format|
      format.html { redirect_to dj_songs_url(@dj) }
      format.json { head :ok }
    end
  end

end
