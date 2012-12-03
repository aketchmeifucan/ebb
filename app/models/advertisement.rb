class Advertisement < ActiveRecord::Base
	attr_accessible :height, :image, :width, :x_location, :y_location

	has_many :tiles
	belongs_to :user
	belongs_to :board
	has_many :payment_details, as: :payable

	validates :image, presence: true
	#  @boardWidth = Board.find(self.board_id).width
	validates_numericality_of :x_location, :greater_than => 0
	validate :check_advertisement_bounds
	#  before_save {self.x_location <= self.board.width}
	#  before_save {self.x_location <= Board.find(self.board_id).width}
	validates :y_location, presence: true
	validates :x_location, presence: true
	validates_numericality_of :y_location, :greater_than => 0
	validates_numericality_of :height, :greater_than => 0
	validates_numericality_of :width, :greater_than => 0
	validates :board, presence: true

	private
	def check_advertisement_bounds
		unless x_location.nil?
			if board.width <= x_location
				errors.add(:x_location, 'x_location exceeds board width')
			end
		end
		unless y_location.nil?
			if board.height <= y_location
				errors.add(:y_location, 'y_location exceeds board height')
			end
		end
		unless width.nil?
			if width > board.width
				errors.add(:width, 'advertisement width larger than board width')
			end
		end
		unless y_location.nil? || height.nil?
			if (y_location + height) > board.height
				errors.add(:y_location, 'advertisement y_location plus height exceeds the board height')
			end
		end
		unless x_location.nil? || width.nil?
			if (x_location + width) > board.width
				errors.add(:x_location, 'advertisement x_location plus width exceeds the board width')
			end
		end
	end
end
