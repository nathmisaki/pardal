# encoding: utf-8
module CurrentUsersHelper
  def students_owned(user)
    content = user.objects_with_role(:owner, Student, true).inject("") do |ret,student|
      ret << content_tag(:li, "Matrícula atribuída: #{student.registration}")
    end
    content_tag :ul, content
  end
end
