class SingersController < ApplicationController
  load_and_authorize_resource
  # GET /singers
  # GET /singers.json
  def index
    @singers = Singer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @singers }
    end
  end

  # GET /singers/1
  # GET /singers/1.json
  def show
    @singer = Singer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @singer }
    end
  end

  # GET /singers/new
  # GET /singers/new.json
  def new
    @singer = Singer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @singer }
    end
  end

  # GET /singers/1/edit
  def edit
    @singer = Singer.find(params[:id])
  end

  # POST /singers
  # POST /singers.json
  def create
    @singer = Singer.new(params[:singer])

    respond_to do |format|
      if @singer.save
        format.html { redirect_to @singer, notice: 'Singer was successfully created.' }
        format.json { render json: @singer, status: :created, location: @singer }
      else
        format.html { render action: "new" }
        format.json { render json: @singer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /singers/1
  # PUT /singers/1.json
  def update
    @singer = Singer.find(params[:id])

    respond_to do |format|
      if @singer.update_attributes(params[:singer])
        format.html { redirect_to @singer, notice: 'Singer was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @singer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /singers/1
  # DELETE /singers/1.json
  def destroy
    @singer = Singer.find(params[:id])
    @singer.destroy

    respond_to do |format|
      format.html { redirect_to singers_url }
      format.json { head :ok }
    end
  end
end
