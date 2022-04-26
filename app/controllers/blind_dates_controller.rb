class BlindDatesController < ActionController::Base

	def create
    groups = BlindDate.generate_groups
    groups.each do |emp_ids|
      BlindDate.create({groups: emp_ids})
    end
    leader_ids = BlindDate.next_meeting_groups.pluck(:leader_id)
    Employee.where(role: 1).update_all(role: 0)
    Employee.where(id: leader_ids).update_all(role: 1)
    redirect_to groups_blind_dates_path
  end

  def update
    bd = BlindDate.find_by_id params[:id]
    bd.update(location: params["location"])
    redirect_to root_path, notice: "Updated successfully"
  end

  def groups
    if current_employee.is_admin?
      @previous_blind_dates, @new_blind_dates = [], []
      @respondees_count = Employee.where.not(opt_in: nil).count
      @total_emps_count = Employee.count
      prev_meet = BlindDate.last_meeting_groups
      groups = prev_meet.pluck(:groups)
      upcoming_meet = BlindDate.next_meeting_groups
      new_groups = upcoming_meet.pluck(:groups)#.select{|g| g.include?(current_user.id)}
      groups.each do |idz|
        @previous_blind_dates << Employee.left_outer_joins(:team, :blind_date).where(id: idz).select("employees.id, employees.name, teams.name AS team_name, blind_dates.leader_id AS
                                    leader_id")
      end
      @prev_leaders = prev_meet.pluck(:leader_id)
      new_groups.each do |idz|
        @new_blind_dates << Employee.left_outer_joins(:team, :blind_date).where(id: idz).select("employees.id, employees.name, teams.name AS team_name, blind_dates.leader_id AS
                                leader_id")
      end
      @new_leaders = upcoming_meet.pluck(:leader_id)
    else
      redirect_to root_path, alert: 'Only Admin can view that page'
    end
  end
end
