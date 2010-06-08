# == Schema Information
#
# Table name: course_schedules
#
#  id                 :integer(4)      not null, primary key
#  course_semester_id :integer(4)
#  weekday            :integer(4)
#  start_hour         :time
#  end_hour           :time
#  created_at         :datetime
#  updated_at         :datetime
#

class CourseSchedule < ActiveRecord::Base
  WEEKDAY = {
    1 => "Domingo",
    2 => "Segunda",
    3 => "Terça",
    4 => "Quarta",
    5 => "Quinta",
    6 => "Sexta",
    7 => "Sábado"
  }
  belongs_to :course_semester

  def short
    "#{WEEKDAY[weekday]} (#{start_hour.strftime("%Hh%Mmin")}~#{end_hour.strftime("%Hh%Mmin")})"
  end

  def conflict_hours?(course_schedule)
    (weekday == course_schedule.weekday) and (
      #inicia durante a aula || S >= SO > E || SO <= S && SO > E
      (course_schedule.start_hour >= self.start_hour and course_schedule.start_hour < self.end_hour) or
      #termina durante a aula || S <= EO < E || EO >= S && EO < E
      (course_schedule.end_hour > self.start_hour and course_schedule.end_hour <= self.end_hour)
    )
  end
end
