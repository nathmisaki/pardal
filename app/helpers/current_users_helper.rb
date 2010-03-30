# encoding: utf-8
module CurrentUsersHelper
  def students_owned(user)
    user.objects_with_role(:owner, Student).map(&:authorizable).inject("") do |ret,student|
      ret << content_tag(:li, "Matrícula atribuída: #{student.registration}")
    end
  end
end
