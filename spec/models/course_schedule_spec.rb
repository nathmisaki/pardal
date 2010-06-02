require 'spec_helper'

describe CourseSchedule do
  it "#short should return a short representation of schedule" do
    course_schedule = CourseSchedule.new(:weekday => 2, :start_hour => '10:20', :end_hour => '12:40')
    course_schedule.short.should == "Segunda (10h20min~12h40min)"
  end

  describe "#conflict_hours?" do
    def sched(weekday, start_hour, end_hour)
      wd = {:seg => 2, :ter => 3, :qua => 4, :qui => 5, :sex => 6, :sab => 7, :dom => 1}
      weekday = wd[weekday] if weekday.is_a?(Symbol)

      CourseSchedule.new(:weekday => weekday, :start_hour => start_hour, :end_hour => end_hour)
    end

    context "Schedule(:seg, 15:20, 17:10)" do
      subject { sched(:seg, '15:20', '17:10') }
      
      it { should be_conflict_hours(sched(:seg, '15:20', '17:10')) }
      
      it { should be_conflict_hours(sched(:seg, '16:25', '18:05')) }

      it { should be_conflict_hours(sched(:seg, '13:00', '16:20')) }

      it { should_not be_conflict_hours(sched(:ter, '15:20', '17:10')) }

      it { should_not be_conflict_hours(sched(:seg, '13:00', '15:20')) }

      it { should_not be_conflict_hours(sched(:seg, '17:10', '20:00')) }
    end
  end
end
