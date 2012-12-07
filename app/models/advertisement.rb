class Advertisement < ActiveRecord::Base
	attr_accessible :height, :image, :width, :x_location, :y_location, :image_contents

	has_many :tiles
	belongs_to :user
	belongs_to :board
	has_many :payment_details, as: :payable

	validates :image, presence: true
	#  @boardWidth = Board.find(self.board_id).width
	validates_numericality_of :x_location, :greater_than_or_equal_to => 0
	validate :check_advertisement_bounds
	#  before_save {self.x_location <= self.board.width}
	#  before_save {self.x_location <= Board.find(self.board_id).width}
	validates :y_location, presence: true
	validates :x_location, presence: true
	validates_numericality_of :y_location, :greater_than_or_equal_to => 0
	validates_numericality_of :height, :greater_than => 0
	validates_numericality_of :width, :greater_than => 0
	validates :board, presence: true

	before_create :createTiles

	def image_contents=(object)
		self.image = object.read
	end

	def charge
		payment_entry = payment_details.build()
		payment_entry.amount = 0
		tiles.each do |t|
			payment_entry.amount += t.cost
			puts "tile x= #{t.x_location} y= #{t.y_location} cost= #{t.cost}"
		end
		payment_entry.user = user
		payment_entry.save
		puts "payment_entry= #{payment_entry.amount}"
	end

	private

	def createTiles
		for c in x_location..(width + x_location - 1)
			for r in y_location..(height + y_location - 1)
				t = tiles.build(x_location: c, y_location: r)
				oldT = board.tiles.where(x_location: c, y_location: r).first
#				puts "width= #{width} height= #{height} x= #{x_location} y= #{y_location} c= #{c} r= #{r}"
				if oldT.nil?
					t.cost = 1
				else
					t.cost = oldT.cost * 2
					if t.cost < 1
						t.cost = 1
					end
				end
			end
		end
		charge
	end
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
		unless height.nil?
			if height > board.height
				errors.add(:height, 'advertisement height larger than board height')
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
