class SonglistsController < ApplicationController
  authorize_resource :class => false
  before_filter :set_dj

  def set_dj
    @dj = current_user.dj
  end

  # GET /songlist
  def show
    if @dj.songs.empty?
      flash.now[:info] = "Import a songlist to get started."
    end
  end

  # GET /songlist/import
  def import
  end

  # GET /songlist/export
  def export
  end

  # PUT /songlist
  # upload file
  def update
    respond_to do |format|
      unless @dj.update_attributes(params[:dj])
        format.html { render action: :import }
        format.json { head :ok }
      else
        format.html { render action: :import }
        format.json { render json: @dj.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /songlist/load
  # load songs from file into @dj.songs
  def load
    if params[:replace]
      @dj.songs.destroy_all
    end
    
    respond_to do |format|
      if @dj.load_songlist(@dj.songlist.path)
        format.html { redirect_to songlist_path, notice: 'Songlist successfully imported' }
        format.json { head :ok }
      else
        format.html { render action: :import }
        format.json { render json: @dj.errors, status: :unprocessable_entity }
      end
    end
  end

 ## DELETE /songlist
 #def destroy
 #  #delete file and remove dj.songlist
 #  respond_to do |format|
 #    format.html { redirect_to djs_url }
 #    format.json { head :ok }
 #  end
 #end
end
