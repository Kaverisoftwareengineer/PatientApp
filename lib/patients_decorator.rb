class BasicPatient
  def initialize(c)
    @description = "Consultation Fee"
    @cost = c
  end

  # getter method
  def cost
    return @cost
  end

  # a method which returns a string representation of the object of type BasicPatientSummary
  def details
    return @description + ": " + "#{@cost}"
  end
end # end the PatientSummary class

class PatientDecorator < BasicPatient
  def initialize(basic_patient)
    @basic_patient = basic_patient
    super(@basic_patient.cost)
    @extra_cost = 0
    @requests = "No consultation fees this time"
  end

  def cost
    return @extra_cost + @basic_patient.cost
 end

  def details
    return @description + ": " + "#{@extra_cost}" + ". " + @basic_patient.details
  end

end #end the PatientDecorator class

class XrayDecorator < PatientDecorator
  def initialize(basic_patient)
    super(basic_patient)
    @extra_cost = 95.0
    @description = "X-ray"
  end
end # end XrayDecorator class

class MriDecorator < PatientDecorator
  def initialize(basic_patient)
    super(basic_patient)
    @extra_cost = 125.0
    @description = "MRI"
  end
end # end MriDecorator class

class BloodDecorator < PatientDecorator
  def initialize(basic_patient)
    super(basic_patient)
    @extra_cost = 30.0
    @description = "Bloods"
  end
end # end BloodDecorator class
