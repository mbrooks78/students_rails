class AwardsController < ApplicationController
  before_action :set_award, only: [:show, :edit, :update, :destroy]
  before_action :get_student, :check_login

  # GET /awards
  # GET /awards.json
  def index
    @awards = @student.awards
  end

  # GET /awards/1
  # GET /awards/1.json
  def show
    @award = @student.awards.find(params[:id])
  end

  # GET /awards/new
  def new
    @student = Student.find(params[:student_id])
    @award = @student.awards.build
  end

  # GET /awards/1/edit
  def edit
    @award = @student.awards.find(params[:id])
  end

  # POST /awards
  # POST /awards.json
  def create
    @award = @student.awards.build(params[award_params])

    #Tell the AwardMailer to send a notice Email #AwardMailer.award_email(@award).deliver

    respond_to do |format|
      if @award.save
        format.html { redirect_to student_awards_url(@student), notice: 'Award was successfully created.' }
        format.json { render :show, status: :created, location: @award }
      else
        format.html { render :new }
        format.json { render json: @award.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /awards/1
  # PATCH/PUT /awards/1.json
  def update
    respond_to do |format|
      if @award.update(award_params)
        format.html { redirect_to student_awards_url(@student), notice: 'Award was successfully updated.' }
        format.json { render :show, status: :ok, location: @award }
      else
        format.html { render :edit }
        format.json { render json: @award.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /awards/1
  # DELETE /awards/1.json
  def destroy
    @award = @student.awards.find(params[:id])
    @award.destroy
    respond_to do |format|
      format.html { redirect_to (student_awards_path(@student)), notice: 'Award was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_award
      @award = Award.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def award_params
      params.require(:award).permit(:name, :year, :student_id)
    end

    # get_student converts the student_id given by the routing
    # into a @student object, for use here and in the view.
    def get_student
      @student = Student.find(params[:student_id])
    end
end
