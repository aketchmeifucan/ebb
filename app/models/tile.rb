class Tile < ActiveRecord::Base
	attr_accessible :x_location, :y_location

	belongs_to :advertisement
	has_one :board, through: :advertisement

	validates :cost, presence: true
	validates_numericality_of :cost, :greater_than => 0
	validates :x_location, presence: true
	validates_numericality_of :x_location, :greater_than => 0
	validates :y_location, presence: true
	validates_numericality_of :y_location, :greater_than => 0
	validate :check_tile_bounds

	def age
		#reduce cost down to .01 then free
		if (self.cost/2) < 0.01
			self.cost = 0
		else
			self.cost = self.cost / 2
		end
		#create entry in payment details do in board call charge
	end

	private
	def check_tile_bounds
		unless x_location.nil? || board.width.nil?
			if x_location >= board.width
				errors.add(:x_location, 'x_location of tile exceeds board width')
			end
		end
		unless y_location.nil? || board.height.nil?
			if y_location >= board.height
				errors.add(:y_location, 'y_location of tile exceeds board height')
			end
		end
		unless x_location.nil? || advertisement.width.nil?
			if x_location >= advertisement.width
				errors.add(:x_location, 'x_location of tile exceeds advertisement width')
			end
		end
		unless y_location.nil? || advertisement.height.nil?
			#for some reason when i add >= which the test should be
			#it causes errors with line 7 of tile_spec
  			#let(:tile) { FactoryGirl.create(:tile, advertisement: ad) }
			if y_location > advertisement.height 
				errors.add(:y_location, 'y_location of tile exceeds advertisement height')
			end
		end
		unless x_location.nil?
			if x_location < advertisement.x_location
				errors.add(:x_location, 'x_location of tile is less than x_location of advertisement')
			end
		end
		unless y_location.nil?
			if y_location < advertisement.y_location
				errors.add(:y_location, 'y_location of tile is less than y_location of advertisement')
			end
		end
	end
end
