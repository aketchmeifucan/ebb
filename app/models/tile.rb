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

  private
  def check_tile_bounds
	  if x_location > board.width
		  errors.add(:x_location, 'x_location of tile exceeds board width')
	  end
	  if y_location > board.height
		  errors.add(:y_location, 'y_location of tile exceeds board height')
	  end
	  if x_location > advertisement.width
		  errors.add(:x_location, 'x_location of tile exceeds advertisement width')
	  end
	  if y_location > advertisement.height
		  errors.add(:y_location, 'y_location of tile exceeds advertisement height')
	  end
	  if x_location < advertisement.x_location
		  errors.add(:x_location, 'x_location of tile is less than x_location of advertisement')
	  end
	  if y_location < advertisement.y_location
		  errors.add(:y_location, 'y_location of tile is less than y_location of advertisement')
	  end
  end
end
