module BlindDateHelper
	def is_thursday?
    DateTime.now.utc.thursday?
  end

  def get_response_ratio(respondees_count, total_emps_count)
    (respondees_count.to_f / total_emps_count) * 100
  end

  def get_blind_date_data
    @blind_date = BlindDate.next_meeting_groups.select{|gp| gp.groups.include?(current_employee.id.to_s)}.first
  end
end
