require 'patients_decorator'
class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  # GET /patients
  # GET /patients.json
  def index
    @patients = Patient.all
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new()
    @patient.firstname = params[:patient][:firstname]
    @patient.lastname = params[:patient][:lastname]
    @patient.phone_number = params[:patient][:phonenumber]
    @patient.address = params[:patient][:address]
    @patient.cost = params[:patient][:cost]

    # create an instance/object of a BasicPatientSummary
    myPatient = BasicPatient.new(@patient.cost)
    # create an instance/object of a BasicPatientSummary
    # myPatient = BasicPatient.new(0, @patient.firstname, @patient.lastname, @patient.phone_number, @patient.address)

    # add the extra features to the new patient
    if params[:patient][:standard_fee].to_s.length > 0 then myPatient = StandardFeeDecorator.new(myPatient)
    end

    if params[:patient][:x_ray].to_s.length > 0 then myPatient = XrayDecorator.new(myPatient)
    end

    if params[:patient][:mriscan_required].to_s.length > 0 then myPatient = MriDecorator.new(myPatient)
    end

    if params[:patient][:bloods_required].to_s.length > 0 then myPatient = BloodDecorator.new(myPatient)
    end

    ## populate the cost and the description details
    @patient.cost = myPatient.cost
    @patient.description = myPatient.details
    respond_to do |format|

    if @patient.save
    format.html { redirect_to @patient, notice: 'Patient was successfully created.'}
    format.json { render :show, status: :created, location: @patient }
    else
    format.html { render :new }
    format.json { render json: @patient.errors, status: :unprocessable_entity }
    end
  end
end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:firstname, :lastname, :phone_number, :address, :description)
    end
end
