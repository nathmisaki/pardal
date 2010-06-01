class Time
  # 20101 20102 20111
  def year_semester
    year*10+semester
  end

  def semester
    (month-1)/6+1
  end
end
