class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]
  skip_before_filter  :verify_authenticity_token

  # GET /attendances
  # GET /attendances.json
  def index
    entries = Project.find(params[:project_id]).entries
    attendance_books = []
    entries.find_each do |entry|
      attendance = {}
      attendance[:entry_id] = entry.id
      attendance[:entry_name] = User.find(entry.user_id).name
      attendance[:attendance] = entry.attendances
      attendance_books.push attendance
    end
    attendance_book = {}
    attendance_book[:attendance_book] = attendance_books
    render json: attendance_book
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
  end

  # GET /attendances/1/edit
  def edit
  end

  # POST /project/15/attendances
  # POST /attendances.json
  def create
    # note : 출석부 생성시는 동기화로 묶었는데 이게 맞을까?
    #@@lock = Mutex.new
      project = Project.find(params[:project_id])
      number = project.entries[0].attendances.maximum("number")+1
      project.entries.find_each do | entry | entry.attendances.create number: number, join_yn: '' end
    #synchronize :expire, :with => :@@lock
    render json:{notice: 'success'}, status: :ok
  end

  # PATCH/PUT /attendances/1
  # PATCH/PUT /attendances/1.json
  def update
    custom_param = attendance_params

    if custom_param[:join_yn] == "Y"
      custom_param[:join_yn] = "N"
    else
      custom_param[:join_yn] = "Y"
    end

    # custom_param[:join_yn] = custom_param[:join_yn] == "" ? 'Y' : (custom_param[:join_yn] == "Y" ? 'Y' :'N')
    p custom_param
    @attendance.update(custom_param)
    render json:{notice: 'success', join_yn: custom_param[:join_yn]}, status: :ok
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendances_url, notice: 'Attendance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_params
      params.require(:attendance).permit(:entry_id, :number, :join_yn)
    end
end
