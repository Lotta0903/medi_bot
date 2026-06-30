class MedicationsController < ApplicationController
  def index
    @medications = current_user.medications
  end

  def new
    @medication = Medication.new
  end

  def create
    @medication = Medication.new(medication_params)
    @medication.user = current_user
    if @medication.save
      redirect_to medications_path
    else
      render :new
    end
  end

  private

  def medication_params
    params.require(:medication).permit(:name, :dosage, :reminder_time)
  end
end
