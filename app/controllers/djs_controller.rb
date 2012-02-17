class DjsController < ApplicationController
  load_and_authorize_resource
  # GET /djs
  # GET /djs.json
  def index
    @djs = Dj.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @djs }
    end
  end

  # GET /djs/1
  # GET /djs/1.json
  def show
    @dj = Dj.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dj }
    end
  end

  # GET /djs/1/edit
  def edit
    @dj = Dj.find(params[:id])
  end

  # PUT /djs/1
  # PUT /djs/1.json
  def update
    @dj = Dj.find(params[:id])

    respond_to do |format|
      if @dj.update_attributes(params[:dj])
        format.html { redirect_to root_path, notice: 'Your preferences were successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @dj.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /djs/1
  # DELETE /djs/1.json
  def destroy
    @dj = Dj.find(params[:id])
    @dj.destroy

    respond_to do |format|
      format.html { redirect_to djs_url }
      format.json { head :ok }
    end
  end
end
