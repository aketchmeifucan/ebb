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

  private
  def check_advertisement_bounds
	  if board.width <= x_location
		  errors.add(:x_location, 'x_location exceeds board width')
	  end
	  if board.height <= y_location
		  errors.add(:y_location, 'y_location exceeds board height')
	  end
	  if width > board.width
		  errors.add(:width, 'advertisement width larger than board width')
	  end
	  if (y_location + height) > board.height
		  errors.add(:y_location, 'advertisement y_location plus height exceeds the board height')
	  end
	  if (x_location + height) > board.width
		  errors.add(:x_location, 'advertisement x_location plus width exceeds the board width')
	  end
  end
end
