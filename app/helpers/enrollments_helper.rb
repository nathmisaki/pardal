module EnrollmentsHelper
  def enrollment_status(enrollment)
    if enrollment.errors.empty?
      if enrollment.situation.nil?
        "incomplete"
      else
        if enrollment.situation.active
          "valid"
        else
          if enrollment.situation.desc =~ /Aguardando/i
            "waiting"
          else
            "invalid"
          end
        end
      end
    else
      "invalid"
    end
  end
end
