class LessonvocasController < ApplicationController
  before_action :set_lessonvoca, only: [:show, :edit, :update, :destroy]

  # GET /lessonvocas
  # GET /lessonvocas.json
  def index
    @lessonvocas = Lessonvoca.all
  end

  # GET /lessonvocas/1
  # GET /lessonvocas/1.json
  def show
  end

  # GET /lessonvocas/new
  def new
    @lessonvoca = Lessonvoca.new
  end

  # GET /lessonvocas/1/edit
  def edit
  end

  # POST /lessonvocas
  # POST /lessonvocas.json
  def create
    @lessonvoca = Lessonvoca.new(lessonvoca_params)

    respond_to do |format|
      if @lessonvoca.save
        format.html { redirect_to @lessonvoca, notice: 'Lessonvoca was successfully created.' }
        format.json { render action: 'show', status: :created, location: @lessonvoca }
      else
        format.html { render action: 'new' }
        format.json { render json: @lessonvoca.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessonvocas/1
  # PATCH/PUT /lessonvocas/1.json
  def update
    respond_to do |format|
      if @lessonvoca.update(lessonvoca_params)
        format.html { redirect_to @lessonvoca, notice: 'Lessonvoca was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lessonvoca.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessonvocas/1
  # DELETE /lessonvocas/1.json
  def destroy
    @lessonvoca.destroy
    respond_to do |format|
      format.html { redirect_to lessonvocas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lessonvoca
      @lessonvoca = Lessonvoca.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lessonvoca_params
      params.require(:lessonvoca).permit(:lesson_id, :vocabulary_id, :name)
    end
end
