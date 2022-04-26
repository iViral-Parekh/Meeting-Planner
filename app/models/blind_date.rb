class BlindDate < ApplicationRecord
	before_save :set_meeting_date
  before_create :choose_leader

  scope :last_meeting_groups, -> { where(meeting_date: DateTime.now.utc.beginning_of_day.prev_occurring(:friday)) }
  scope :next_meeting_groups, -> { where(meeting_date: DateTime.now.utc.beginning_of_day.next_occurring(:friday)) }

  has_many :blind_date_employees
  has_many :employees, through: :blind_date_employees
  belongs_to :leader, class_name: "Employee", optional: true

	def set_meeting_date
		self.meeting_date ||= next_friday
	end

  def next_friday
    DateTime.now.utc.beginning_of_day.next_occurring(:friday)
  end

	def self.generate_groups
    new_groups, res = [], []
    result = get_employees_by_team
    employee_count = Employee.opt_in_employees.size.to_f
    groups_count = (employee_count / 10).ceil
    sample_count = (employee_count / (groups_count * Team.count)).ceil
    groups_count.times do |z|
      if (z + 1) == groups_count
        res = result.values.flatten.compact
      else
        result.each do |k, v|
          s = v.sample(sample_count)
          result[k] -= s
          res << s
        end
      end
      new_groups << res.flatten.compact.map(&:to_i)
      res = []
    end
    prev_dates = BlindDate.last_meeting_groups.pluck(:groups)
    generate_groups if (new_groups & prev_dates).present?
    new_groups
  end

  def choose_leader
    current_leader_ids = BlindDate.last_meeting_groups.pluck(:leader_id)
    new_lead = find_leader(self.groups, current_leader_ids)
    self.leader_id = new_lead
  end

  def find_leader(grp, current_leader_ids)
    new_lead = grp.sample
    find_leader if current_leader_ids.present? && current_leader_ids.include?(new_lead)
    new_lead
  end

  def self.get_employees_by_team
    result = {}
    Team.includes(:employees).each do |x|
      result[x.name] = x.employees.opt_in_employees.ids
    end
    result
  end
end