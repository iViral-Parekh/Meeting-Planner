class BlindDateEmployee < ApplicationRecord
	belongs_to :blind_date
	has_many :employees
end