class Game < ActiveRecord::Base
	before_save :default_values
	
	def default_values
		self.status ||= 0
	end

	validates :name, length: { maximum: 20 }
	validates :max_players, numericality: { greater_than_or_equal_to: 2, less_than_or_equal_to: 6 }

end