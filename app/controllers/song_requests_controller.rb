class SongRequestsController < ApplicationController
  # GET /song_requests
  # GET /song_requests.json
  def index
    if current_user.role == 'admin'
      @song_requests = SongRequest.all
    elsif current_user.role == 'dj'
      @song_request = SongRequest.find(current_user.dj)
    elsif current_user.role == 'singer'
      @song_request = SongRequest.find(current_user.singer)
    end  

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @song_requests }
    end
  end

  # GET /song_requests/1
  # GET /song_requests/1.json
  def show
    @song_request = SongRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @song_request }
    end
  end

  # GET /song_requests/new
  # GET /song_requests/new.json
  def new
    @song_request = SongRequest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @song_request }
    end
  end

  # GET /song_requests/1/edit
  def edit
    @song_request = SongRequest.find(params[:id])
  end

  # POST /song_requests
  # POST /song_requests.json
  def create
    @song_request = SongRequest.new(params[:song_request])

    respond_to do |format|
      if @song_request.save
        format.html { redirect_to @song_request, notice: 'Song request was successfully created.' }
        format.json { render json: @song_request, status: :created, location: @song_request }
      else
        format.html { render action: "new" }
        format.json { render json: @song_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /song_requests/1
  # PUT /song_requests/1.json
  def update
    @song_request = SongRequest.find(params[:id])

    respond_to do |format|
      if @song_request.update_attributes(params[:song_request])
        format.html { redirect_to @song_request, notice: 'Song request was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @song_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /song_requests/1
  # DELETE /song_requests/1.json
  def destroy
    @song_request = SongRequest.find(params[:id])
    @song_request.destroy

    respond_to do |format|
      format.html { redirect_to song_requests_url }
      format.json { head :ok }
    end
  end
end
