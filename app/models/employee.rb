class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	has_one :employee_team, dependent: :destroy
	has_one :team, through: :employee_team
	has_many :blind_date, foreign_key: :leader_id

	validates_uniqueness_of :email
  enum role: ["employee", "leader", "admin"]

  scope :opt_in_employees, -> { where(opt_in: true) }

  def is_employee?
    self.role == "employee"
  end

  def is_leader?
    self.role == "leader"
  end

  def is_admin?
    self.role == "admin"
  end
end