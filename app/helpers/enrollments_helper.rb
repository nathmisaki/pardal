module EnrollmentsHelper
  def enrollment_status(enrollment)
    if enrollment.errors.empty?
      if enrollment.situation.nil?
        "incomplete"
      else
        if enrollment.situation.active
          "valid"
        else
          "waiting"
        end
      end
    else
      "invalid"
    end
  end
end
