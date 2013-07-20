class SongRequestsController < ApplicationController
 #before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /song_requests
  # GET /song_requests.json
  def index
    if user_signed_in?
      if current_user.admin?
        @song_requests = SongRequest.all
        template = 'admin_index'
      elsif current_user.dj? or current_user.singer?
        @song_requests = current_user.account.song_requests.where(:archived => false)
        @archived_song_requests = current_user.account.song_requests.where(:archived => true)
        template = current_user.role+'_index'
      else
        template = 'guest_index'
        #redirect_to :root and return false
      end 
    else
      template = 'guest_index'
      #redirect_to :root and return false
    end

    respond_to do |format|
      format.html { render template rescue nil}# [role_]index.html.erb
      format.json { render json: @song_requests }
    end
  end

  # GET /song_requests/1
  # GET /song_requests/1.json
  def show
    @song_request = SongRequest.find(params[:id])
    @dj = @song_request.dj
    @song = @song_request.song
    @singer = @song_request.singer

    if user_signed_in?
      template = current_user.role+'_show'
    else
      template = 'guest_show'
    end

    respond_to do |format|
      format.html { render template rescue nil }# [role_]show.html.erb
      format.json { render json: @song_request }
    end
  end

  # GET /song_requests/new
  # GET /song_requests/new.json
  def new
    request_params = {:dj_id => params[:dj_id], :song_id => params[:song_id]}
    @dj = Dj.find(params[:dj_id])
    @song = Song.find(params[:song_id])
    if user_signed_in? and current_user.role == 'singer'
      request_params[:singer_id] = current_user.singer.id
      @singer = current_user.singer
    else
      redirect_to new_user_registration_path, notice: 'Please create an account or sign in before making a song request.' and return false
    end
    @song_request = SongRequest.new(request_params)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @song_request }
    end
  end

  # GET /song_requests/1/edit
  def edit
    @song_request = SongRequest.find(params[:id])
    @dj = @song_request.dj
    @song = @song_request.song
    @singer = @song_request.singer
  end

  # POST /song_requests
  # POST /song_requests.json
  def create
    @song_request = SongRequest.new(params[:song_request])
    @dj = @song_request.dj
    @song = @song_request.song
    @singer = @song_request.singer

    respond_to do |format|
      if @song_request.save
        format.html { redirect_to song_requests_path, notice: 'Song request was successfully created.' }
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
  
  # GET /song_requests/1/archive
  # GET /song_requests/1/archive.json
  def archive
    @song_request = SongRequest.find(params[:id])
    @song_request.update_attributes({:archived => true})
    
    respond_to do |format|
      format.html { redirect_to song_requests_url }
      format.json { head :ok }
    end
  end

  # GET /song_requests/1/unarchive
  # GET /song_requests/1/unarchive.json
  def unarchive
    @song_request = SongRequest.find(params[:id])
    @song_request.update_attributes({:archived => false})
    
    respond_to do |format|
      format.html { redirect_to song_requests_url }
      format.json { head :ok }
    end
  end
end
