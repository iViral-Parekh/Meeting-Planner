module ApplicationHelper
	def is_leader?(employee_id)
    BlindDate.next_meeting_groups.where(leader_id: employee_id).exists?
  end

  def is_admin?(employee)
    employee.is_admin?
  end
end
