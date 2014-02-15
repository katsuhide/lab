class FrientsController < ApplicationController
  before_action :set_frient, only: [:show, :edit, :update, :destroy]

  # GET /frients
  # GET /frients.json
  def index
    @frients = Frient.all
  end

  # GET /frients/1
  # GET /frients/1.json
  def show
  end

  # GET /frients/new
  def new
    @frient = Frient.new
  end

  # GET /frients/1/edit
  def edit
  end

  # POST /frients
  # POST /frients.json
  def create
    @frient = Frient.new(frient_params)

    respond_to do |format|
      if @frient.save
        format.html { redirect_to @frient, notice: 'Frient was successfully created.' }
        format.json { render action: 'show', status: :created, location: @frient }
      else
        format.html { render action: 'new' }
        format.json { render json: @frient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /frients/1
  # PATCH/PUT /frients/1.json
  def update
    respond_to do |format|
      if @frient.update(frient_params)
        format.html { redirect_to @frient, notice: 'Frient was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @frient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /frients/1
  # DELETE /frients/1.json
  def destroy
    @frient.destroy
    respond_to do |format|
      format.html { redirect_to frients_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_frient
      @frient = Frient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def frient_params
      params.require(:frient).permit(:name, :address)
    end
end
